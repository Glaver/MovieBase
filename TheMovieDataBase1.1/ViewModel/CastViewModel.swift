//
//  CastViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 29/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine

final class CastViewModel: ObservableObject {
    @Published var movieId: Int = 0
    @Published var casts = [MovieCast](){
        didSet {
            if casts.count > 0 {
                SaveModelObject.forCast(from: Mappers.toMovieCastObject(from: casts, for: movieId), to: realm)
            }
        }
    }
    
    var castsFromRealm: [MovieCast] {
        if realm.isEmpty {
            return casts
        } else {
            return Mappers.toMovieCast(from: Array(FetchModelObject.forCast(from: realm, for: movieId)), for: movieId)
        }
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        $movieId
            .flatMap { (movieId) -> AnyPublisher<[MovieCast], Never> in
                FetchData.shared.fetchCredits(for: movieId)
            }
            .assign(to: \.casts, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
