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
    @Published var castCrewError: Errors?
    @Published var castAndCrew: MovieCreditResponse? {
        didSet {
            if castAndCrew != nil {
                SaveModelObject.forCredits(from: Mappers.toMovieCreditLists(from: castAndCrew!, for: movieId), to: realm, with: movieId)
            }
        }
    }

    var castAndCrewFromRealm: MovieCreditResponse {
        if realm.isEmpty {
            return castAndCrew!
        } else {
            return Mappers.toMovieCreditResponse(from: (Array(FetchModelObject.forCredits(from: realm, for: movieId)))[0])
        }
    }

    init(movieId: Int, castAndCrew: MovieCreditResponse) {
        self.movieId = movieId
        self.castAndCrew = castAndCrew
        $movieId
            .setFailureType(to: Errors.self)
            .flatMap { (movieId) -> AnyPublisher<MovieCreditResponse, Errors> in
                FetchData.shared.fetchCastAndCrew(endpoint: Endpoint.credits(movieID: movieId))
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.castCrewError = error
                }
            },
                  receiveValue: { [unowned self] in
                    self.castAndCrew = $0
                  })
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []

    deinit {
        for cancel in cancellableSet {
            cancel.cancel()
        }
    }
}
/*            .flatMap { (movieId) -> AnyPublisher<[MovieCast], Never> in
 FetchData.shared.fetchCredits(for: Endpoint.credits(movieID: movieId).finalURL)
}
.assign(to: \.casts, on: self)
.store(in: &self.cancellableSet)
}*/
