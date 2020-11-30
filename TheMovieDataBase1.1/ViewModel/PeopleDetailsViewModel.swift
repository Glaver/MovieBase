//
//  PeopleDetailsViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 30/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine

class PeopleDetailsViewModel: ObservableObject {
    @Published var personId: Int = 0
    @Published var errorPerson: Errors?
    @Published var peopleDetail = PeopleDetailsModel()
    
    init(personId: Int) {//, realmService: MovieDetailsRealm, mappers: MovieDetailsMappersProtocol) {
        self.personId = personId
        //self.realmService = realmService
        //self.mappers = mappers
        $personId

            .setFailureType(to: Errors.self)
            .flatMap { (personId) -> AnyPublisher<PeopleDetailsModel, Errors> in
                FetchData.shared.fetchInstance(for: PeopleDetailsModel(), endpoint: Endpoint.person(personId: personId))
                //FetchData.shared.fetchMovieDetailError(from: movieId)
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.errorPerson = error
                }},
                  receiveValue: { [unowned self] in
                    self.peopleDetail = $0
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
