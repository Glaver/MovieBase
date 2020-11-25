//
//  MovieResponse.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

final class GenreViewModel: ObservableObject {
    let realmService: GenresRealmProtocol
    let mappers: GenresMappersProtocol
    @Published var genresEndpoint = Endpoint.tvGenres
    @Published var errorGenres: Errors?
    @Published var genres = [GenresDTO]() {
        didSet {
            if !genres.isEmpty {
                realmService.save(from: genres, to: realm)
            }
        }
    }
    var dictionaryGenresFromRealm: GenresDictionary {
        let dictionaryOfGenres = mappers.toGenresDictionary(from: realmService.load(from: realm))
        return dictionaryOfGenres }

    var dictionaryGenres: GenresDictionary { return mappers.toGenresDictionary(from: genres) }

    init(genresEndpoint: Endpoint, realmService: GenresRealmProtocol, mappers: GenresMappersProtocol) {
        self.genresEndpoint = genresEndpoint
        self.realmService = realmService
        self.mappers = mappers
        $genresEndpoint

            .setFailureType(to: Errors.self)
            .flatMap { (genresEndpoint) -> AnyPublisher<[GenresDTO], Errors> in
                FetchData.shared.fetchGenresError(from: genresEndpoint)
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.errorGenres = error
                }},
                  receiveValue: { [unowned self] in
                    self.genres = $0
                  })
            .store(in: &self.cancellationSet)
    }

    var cancellationSet: Set<AnyCancellable> = []

    deinit {
        for cancel in cancellationSet {
            cancel.cancel()
        }
    }
}
