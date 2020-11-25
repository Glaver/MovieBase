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
    enum EndpointTvOrMovie { case tvShow, movie }
    let realmService: CreditsRealmProtocol
    let mappers: CreditsMappersProtocol
    var chooseEndpoint: EndpointTvOrMovie = .movie
    @Published var movieId: Int = 0
    @Published var castCrewError: Errors?
    @Published var castAndCrew = MovieCreditResponse() {
        didSet {
            if castAndCrew.id != 0 {
                let castObject = mappers.toMovieCreditLists(from: castAndCrew, for: castAndCrew.id)
                realmService.save(from: castObject, to: realm, with: castAndCrew.id)
            }
        }
    }
    var castAndCrewFromRealm: MovieCreditResponse {
        if realm.isEmpty {
            return castAndCrew
        } else {
            var movieCreditResponse = MovieCreditResponse()
            let movieCreditObject = Array(realmService.load(from: realm, for: movieId))
            if let section = movieCreditObject[safe: 0] {
                movieCreditResponse = mappers.toMovieCreditResponse(from: section)
            }
            return movieCreditResponse
        }
    }
    private func chooseEndpoint(endpoint: EndpointTvOrMovie, id: Int) -> Endpoint {
        switch endpoint {
        case .movie: return Endpoint.credits(movieID: id)
        case .tvShow: return Endpoint.creditsTV(tvShowID: id)
        }
    }
    init(movieId: Int, chooseEndpoint: EndpointTvOrMovie, realmService: CreditsRealmProtocol, mappers: CreditsMappersProtocol) {
        self.movieId = movieId
        self.castAndCrew = MovieCreditResponse(id: 0, cast: [MovieCast](), crew: [MovieCrew]())
        self.chooseEndpoint = chooseEndpoint
        self.realmService = realmService
        self.mappers = mappers
        $movieId
            .setFailureType(to: Errors.self)
            .flatMap { (movieId) -> AnyPublisher<MovieCreditResponse, Errors> in
                FetchData.shared.fetchInstance(for: MovieCreditResponse(), endpoint: self.chooseEndpoint(endpoint: chooseEndpoint, id: movieId))
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
