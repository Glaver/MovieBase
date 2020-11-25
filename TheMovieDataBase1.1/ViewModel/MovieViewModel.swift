//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.

import Foundation
import Combine
import RealmSwift

enum MoviesList {
    case nowPlaying
    case popular
    case upcoming
    case topRated
}

final class MovieViewModel: ObservableObject {
    let realmService: MovieListRealmProtocol
    let mappers: MovieMappersProtocol
    let filter: FilterContentProtocol
    @Published var indexOfMoviesList: MoviesList = .nowPlaying
    @Published var filteringMoviesIndex: FilterContent.FilteredParameters = .releaseDate
    @Published var moviesError: Errors?
    @Published var moviesDTO = [MovieModel]() {
        didSet {
            if !moviesDTO.isEmpty {
                realmService.save(from: mappers.toMovieModelObjectList(from: moviesDTO), to: realm, with: indexOfMoviesList)
            }
            debugPrint("Path to realm file and images: \(realm.configuration.fileURL!)")
        }
    }
    var moviesFromRealm: [MovieModel] {
        if realm.isEmpty {
            return filter.listOfContent(moviesDTO, by: filteringMoviesIndex) as! [MovieModel]
        } else {
            var movieModel = [MovieModel]()
            if let movieModelObject = realmService.load(from: realm, with: indexOfMoviesList) {
                movieModel = mappers.toMovieModel(from: Array(movieModelObject))
            }
            return filter.listOfContent(movieModel, by: filteringMoviesIndex) as! [MovieModel]
        }
    }
    init(indexOfMoviesList: MoviesList, filteringMoviesIndex: FilterContent.FilteredParameters, realmService: MovieListRealmProtocol, mappers: MovieMappersProtocol, filter: FilterContentProtocol) {
        self.indexOfMoviesList = indexOfMoviesList
        self.filteringMoviesIndex = filteringMoviesIndex
        self.realmService = realmService
        self.mappers = mappers
        self.filter = filter
        $indexOfMoviesList
            .setFailureType(to: Errors.self)
            .flatMap { (indexOfMoviesList) -> AnyPublisher<[MovieModel], Errors> in
                FetchData.shared.fetchMoviesError(from: Endpoint(index: indexOfMoviesList))
                    //.eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.moviesError = error
                }},
                  receiveValue: { [unowned self] in
                    self.moviesDTO = $0
                  })
            .store(in: &self.cancellationSet)
    }

    private var cancellationSet: Set<AnyCancellable> = []

    deinit {
        for cancell in cancellationSet {
            cancell.cancel()
        }
    }
}

//protocol MovieListRealm {
//    func fetchDataFromRealm(index: MoviesList) -> MovieShowViewProtocol
//    func saveDataToRealm(model: MovieShowViewProtocol, index: MoviesList)
//}
