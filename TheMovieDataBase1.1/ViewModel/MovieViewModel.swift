//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.

import Foundation
import Combine
import RealmSwift

final class MovieViewModel: ObservableObject {
    @Published var indexOfMoviesList: MoviesList = .nowPlaying
    @Published var filteringMoviesIndex: FilterMovies = .releaseDate
    @Published var moviesError: Errors?
    @Published var moviesDTO = [ResultDTO]() {
        didSet {
            if !moviesDTO.isEmpty {
                realmService.forMovies(from: Mappers.toMovieModelObjectList(from: moviesDTO), to: realm, with: indexOfMoviesList)
//                SaveModelObject.forMovies(from: Mappers.toMovieModelObjectList(from: moviesDTO), to: realm, with: indexOfMoviesList)
            }
            //debugPrint("Path to realm file and images: \(realm.configuration.fileURL!)")
        }
    }
    let realmService: MovieListRealmProtocol
    var moviesFromRealm: [MovieModel] {
        if realm.isEmpty {
            return Filtering.movies(movieModelArray, by: filteringMoviesIndex)
        } else {
            return Filtering.movies(Mappers.toMovieModel(from: Array(realmService.forMovies(from: realm, with: indexOfMoviesList) ?? Mappers.toMovieModelObjectList(from: moviesDTO))), by: filteringMoviesIndex)
        }
    }

    var movieModelArray: [MovieModel] { return Mappers.toMovieModel(from: moviesDTO) }

    init(indexOfMoviesList: MoviesList, filteringMoviesIndex: FilterMovies, realmService: MovieListRealmProtocol) {
        self.indexOfMoviesList = indexOfMoviesList
        self.filteringMoviesIndex = filteringMoviesIndex
        self.realmService = realmService
        $indexOfMoviesList
            .setFailureType(to: Errors.self)
            .flatMap { (indexOfMoviesList) -> AnyPublisher<[ResultDTO], Errors> in
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

enum MoviesList {
    case nowPlaying
    case popular
    case upcoming
    case topRated
}

//protocol MovieListRealm {
//    func fetchDataFromRealm(index: MoviesList) -> MovieShowViewProtocol
//    func saveDataToRealm(model: MovieShowViewProtocol, index: MoviesList)
//}
