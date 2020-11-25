//
//  MovieDetailViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 9/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MovieDetailViewModel: ObservableObject {
    let realmService: MovieDetailsRealm
    let mappers: MovieDetailsMappersProtocol
    @Published var movieId: Int
    @Published var movieDetailError: Errors?
    @Published var movieDetail = MovieDetailModel() {
            didSet {
                if movieDetail.id != 0 {
                    realmService.save(from: mappers.toMovieDetailObject(from: movieDetail), to: realm)
                }
            }
        }
    var movieDetailsFromRealm: MovieDetailModel {
        if realm.isEmpty {
            return movieDetail
        } else {
            var movieDetails = MovieDetailModel()
            let movieDetailsArray = Array(realmService.load(from: realm, for: movieId))
            if let details = movieDetailsArray[safe: 0] {
                movieDetails = mappers.toMovieDetailModel(from: details)
            }
            return movieDetails
        }
    }
    init(movieId: Int, realmService: MovieDetailsRealm, mappers: MovieDetailsMappersProtocol) {
        self.movieId = movieId
        self.realmService = realmService
        self.mappers = mappers
        $movieId

            .setFailureType(to: Errors.self)
            .flatMap { (movieId) -> AnyPublisher<MovieDetailModel, Errors> in
                FetchData.shared.fetchInstance(for: MovieDetailModel(), endpoint: Endpoint.movieDetail(movieID: movieId))
                //FetchData.shared.fetchMovieDetailError(from: movieId)
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.movieDetailError = error
                }},
                  receiveValue: { [unowned self] in
                    self.movieDetail = $0
                  })
            .store(in: &self.cancellableSet)
    }

    private var cancellableSet: Set<AnyCancellable> = []

    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}

/*
 
 //.setFailureType(to: MoviesError.self)
 .flatMap { (movieId) -> AnyPublisher<MovieDetailModel, Never> in
     FetchData.shared.fetchMovieDetail(for: Endpoint.movieDetail(movieID: movieId).finalURL)
         //.eraseToAnyPublisher()
 }
 .assign(to: \.movieDetail, on: self)
 .store(in: &self.cancellableSet)*/
