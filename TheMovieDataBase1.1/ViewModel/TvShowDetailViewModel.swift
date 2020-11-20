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
            print(tvShowDetail.name)
            print(tvShowDetail.overview)
        }
    }
//    () {
//            didSet {
//                if tvShowDetail.id != 0 {
//                    SaveModelObject.forMovieDetails(from: Mappers.toMovieDetailObject(from: tvShowDetail), to: realm)
//                }
//            }
//        }

//        var movieDetailsFromRealm: MovieDetailModel {
//            if realm.isEmpty {
//                return movieDetail
//            } else {
//                return Mappers.toMovieDetailModel(from: Array(FetchModelObject.forMovieDetails(from: realm, for: movieId))[0])
//            }
//        }

    init(tvShowId: Int) {
        self.tvShowId = tvShowId

        $tvShowId
            .setFailureType(to: Errors.self)
            .flatMap { (tvShowId) -> AnyPublisher<TvShowDetailModel, Errors> in
                FetchData.shared.fetchInstance(for: TvShowDetailModel(), endpoint: Endpoint.tvShowDetail(tvShowID: tvShowId))
                //FetchData.shared.fetchTvShowDetailError(from: tvShowId)
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
