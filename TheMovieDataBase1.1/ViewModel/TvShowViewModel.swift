//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.

import Foundation
import Combine
import RealmSwift

enum TvShowList {
    case airingToday
    case onTheAir
    case popularTV
    case topRatedTV
}

final class TvShowViewModel: ObservableObject {
    let realmService: TvShowListRealmProtocol
    let mappers: TvShowMappersProtocol
    let filter: FilterContentProtocol
    @Published var indexOfTvShowList: TvShowList = .airingToday
    @Published var filteringMoviesIndex: FilterContent.FilteredParameters = .releaseDate
    @Published var tvShowError: Errors?
    @Published var tvShow = [ResultTvModel]() {
        didSet {
            if !tvShow.isEmpty {
                realmService.save(from: mappers.toTvShowObjectList(from: tvShow), to: realm, with: indexOfTvShowList)
            }
        }
    }
    var tvShowFromRealm: [ResultTvModel] {
        if realm.isEmpty {
            return filter.listOfContent(tvShow, by: filteringMoviesIndex) as! [ResultTvModel]
        } else {
            var tvShowModelsFromRealm = [ResultTvModel]()
            if let tvShowList = realmService.load(from: realm, with: indexOfTvShowList) {
                tvShowModelsFromRealm = mappers.toResultTvModel(from: tvShowList)
            }
            return filter.listOfContent(tvShowModelsFromRealm, by: filteringMoviesIndex) as! [ResultTvModel]
        }
    }
    init(indexOfTvShowList: TvShowList, filteringMoviesIndex: FilterContent.FilteredParameters, realmService: TvShowListRealmProtocol, mappers: TvShowMappersProtocol, filter: FilterContentProtocol) {
        self.indexOfTvShowList = indexOfTvShowList
        self.filteringMoviesIndex = filteringMoviesIndex
        self.realmService = realmService
        self.mappers = mappers
        self.filter = filter
        $indexOfTvShowList
            .setFailureType(to: Errors.self)
            .flatMap { (indexOfTvShowList) -> AnyPublisher<[ResultTvModel], Errors> in
                FetchData.shared.fetchTvShow(from: Endpoint(indexTV: indexOfTvShowList))
                    .eraseToAnyPublisher()
            }
            .sink(receiveCompletion: { [unowned self] (completion) in
                if case let .failure(error) = completion {
                    self.tvShowError = error
                }},
                  receiveValue: { [unowned self] in
                    self.tvShow = $0
                  })
            .store(in: &self.cancellationSet)
    }

    private var cancellationSet: Set<AnyCancellable> = []

    deinit {
        for cancel in cancellationSet {
            cancel.cancel()
        }
    }
}
