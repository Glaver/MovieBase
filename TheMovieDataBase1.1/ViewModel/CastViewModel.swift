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
    var trueForMoviesAndFalseForShow = true
    @Published var movieId: Int = 0
    @Published var castCrewError: Errors?
    @Published var castAndCrew: MovieCreditResponse? {
        didSet {
            if let casts = castAndCrew {
                realmService.forCredits(from: Mappers.toMovieCreditLists(from: casts, for: movieId), to: realm, with: movieId)
            }
        }
    }
    let realmService: CreditsRealmProtocol
    var castAndCrewFromRealm: MovieCreditResponse {
        if realm.isEmpty {
            let castOutput: MovieCreditResponse
            if let casts = castAndCrew {
                castOutput = casts
            } else {
                castOutput = MovieCreditResponse()
                debugPrint("can't recive MovieCreditResponse from network and realm")
            }
            return castOutput
        } else {
            return Mappers.toMovieCreditResponse(from: (Array(realmService.forCredits(from: realm, for: movieId)))[0])
        }
    }
    private func chooseEndpoint(trueForMovieFalseForShow: Bool, id: Int) -> Endpoint {
        if trueForMovieFalseForShow {
            return Endpoint.credits(movieID: id)
        } else {
            return Endpoint.creditsTV(tvShowID: id)
        }
    }
    init(movieId: Int, trueForMoviesAndFalseForShow: Bool, realmService: CreditsRealmProtocol) {
        self.movieId = movieId
        self.castAndCrew = MovieCreditResponse(cast: [MovieCast](), crew: [MovieCrew]())
        self.trueForMoviesAndFalseForShow = trueForMoviesAndFalseForShow
        self.realmService = realmService
        $movieId
            .setFailureType(to: Errors.self)
            .flatMap { (movieId) -> AnyPublisher<MovieCreditResponse, Errors> in
                FetchData.shared.fetchInstance(for: MovieCreditResponse(), endpoint: self.chooseEndpoint(trueForMovieFalseForShow: trueForMoviesAndFalseForShow, id: movieId))
                //FetchData.shared.fetchCastAndCrew(endpoint: Endpoint.credits(movieID: movieId))
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
