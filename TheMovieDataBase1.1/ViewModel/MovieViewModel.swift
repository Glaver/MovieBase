//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.

import Foundation
import Combine
import RealmSwift

let realm = try! Realm()

final class MovieViewModel: ObservableObject {
    @Published var indexOfMoviesList: MoviesList = .nowPlaying
    @Published var filteringMoviesIndex: FilterMovies = .releaseDate
    @Published var moviesError: MoviesError?
    @Published var moviesDTO = [ResultDTO]() {
        didSet {
            if moviesDTO.count > 0 {
                SaveModelObject.forMovies(from: Mappers.toMovieModelObjectList(from: moviesDTO), to: realm, with: indexOfMoviesList)
            }
            print("Path to realm file and images: \(realm.configuration.fileURL!)")
        }
    }
    
    var moviesFromRealm: [MovieModel] {
        if realm.isEmpty {
            return Filtering.movies(movieModelArray, by: filteringMoviesIndex)
        } else {
            return Filtering.movies(FetchModelObject.forMovies(from: realm, with: indexOfMoviesList), by: filteringMoviesIndex)
        }
    }
    
    var movieModelArray: [MovieModel] { return Mappers.toMovieModel(from: moviesDTO) }
    
    init(indexOfMoviesList: MoviesList, filteringMoviesIndex: FilterMovies) {
        self.indexOfMoviesList = indexOfMoviesList
        self.filteringMoviesIndex = filteringMoviesIndex
        
        $indexOfMoviesList
            .setFailureType(to: MoviesError.self)
            .flatMap { (indexOfMoviesList) -> AnyPublisher<[ResultDTO], MoviesError> in
                FetchData.shared.fetchMoviesError(from: Endpoint(index: indexOfMoviesList)!)
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.moviesError = error
                }},
                  receiveValue: { [unowned self] in
                    self.moviesDTO = $0
                  })
    }
    
    private var cancellationSet: Set<AnyCancellable> = []
    
    deinit {
        for cancell in cancellationSet {
            cancell.cancel()
        }
    }
}

/* $indexOfMoviesList
 .flatMap{ (indexOfMoviesList) -> AnyPublisher<[ResultDTO], Never> in
 FetchData.shared.fetchMovies(from: Endpoint(index: indexOfMoviesList)!)
}
.assign(to: \.moviesDTO, on: self)
.store(in: &self.cancellationSet)*/
