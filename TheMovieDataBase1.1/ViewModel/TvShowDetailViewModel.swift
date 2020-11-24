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
//, nextEpisodeToAir: nil
class TvShowDetailViewModel: ObservableObject {
    @Published var tvShowId: Int
    @Published var tvShowDetailError: Errors?
    @Published var tvShowDetail = TvShowDetailModel() {
        didSet {
            if tvShowDetail.id != 0 {
                print(tvShowDetail.name)
                let tvShowDetailObject = Mappers.toTvShowDetailObject(from: tvShowDetail)
                SaveModelObject.forTvShowDetails(from: tvShowDetailObject, to: realm)
            }
        }
    }
    var tvShowDetailFromRealm: TvShowDetailModel {
        if realm.isEmpty {
            return tvShowDetail
        } else {
            var output = TvShowDetailModel()
            let showDetail = Array(FetchModelObject.forTvShowDetails(from: realm, for: tvShowId))
            if let section = showDetail[safe: 0] {
                output = Mappers.toTvShowDetail(from: section)
            }
            return output
        }
    }

    init(tvShowId: Int) {
        self.tvShowId = tvShowId

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
