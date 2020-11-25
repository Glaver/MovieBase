//
//  TvShowDetailViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class TvShowDetailViewModel: ObservableObject {
    @Published var tvShowId: Int
    @Published var tvShowDetailError: Errors?
    @Published var tvShowDetail = TvShowDetailModel() {
        didSet {
            if tvShowDetail.id != 0 {
                let tvShowDetailObject = mappers.toTvShowDetailObject(from: tvShowDetail)
                realmService.save(from: tvShowDetailObject, to: realm)
            }
        }
    }
    let realmService: TvShowDetailsRealmProtocol
    let mappers: TvShowDetailsMappersProtocol
    var tvShowDetailFromRealm: TvShowDetailModel {
        if realm.isEmpty {
            return tvShowDetail
        } else {
            var tvShowDetailModel = TvShowDetailModel()
            let showDetail = Array(realmService.load(from: realm, for: tvShowId))
            if let section = showDetail[safe: 0] {
                tvShowDetailModel = mappers.toTvShowDetail(from: section)
            }
            return tvShowDetailModel
        }
    }

    init(tvShowId: Int, realmService: TvShowDetailsRealmProtocol, mappers: TvShowDetailsMappersProtocol) {
        self.tvShowId = tvShowId
        self.realmService = realmService
        self.mappers = mappers
        $tvShowId
            .setFailureType(to: Errors.self)
            .flatMap { (tvShowId) -> AnyPublisher<TvShowDetailModel, Errors> in
                FetchData.shared.fetchInstance(for: TvShowDetailModel(), endpoint: Endpoint.tvShowDetail(tvShowID: tvShowId))
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.tvShowDetailError = error
                }},
                  receiveValue: { [unowned self] in
                    self.tvShowDetail = $0
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
