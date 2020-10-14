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
    @Published var movieId : Int
    @Published var movieDetail = MovieDetailModel() {
            didSet {
                if movieDetail.id != 0 {
                    SaveModelObject.forMovieDetails(from: Mappers.toMovieDetailObject(from: movieDetail), to: realm)
                }
            }
        }
        
        var movieDetailsFromRealm: MovieDetailModel {
            if realm.isEmpty {
                return movieDetail
            } else {
                print("load from Realm " + String(movieId))
                return Mappers.toMovieDetailModel(from: Array(FetchModelObject.forMovieDetails(from: realm, for: movieId))[0])
            }
        }
        
    init(movieId: Int) {
        self.movieId = movieId
        $movieId
            //.setFailureType(to: MoviesError.self)
            .flatMap { (movieId) -> AnyPublisher<MovieDetailModel, Never> in
                FetchData.shared.fetchMovieDetail(for: movieId )
                    //.eraseToAnyPublisher()
            }
            .assign(to: \.movieDetail, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
