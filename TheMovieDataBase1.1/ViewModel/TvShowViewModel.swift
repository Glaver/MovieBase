//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.

import Foundation
import Combine
import RealmSwift

final class TvShowViewModel: ObservableObject {
    @Published var indexOfTvShowList: TvShowList = .airingToday
    @Published var filteringMoviesIndex: FilterMovies = .releaseDate
    @Published var tvShowError: Errors?
    @Published var tvShow = [ResultTvModel]() {
        didSet {
            if !tvShow.isEmpty {
                SaveModelObject.forTvShow(from: Mappers.toTvShowObjectList(from: tvShow), to: realm, with: indexOfTvShowList)
            }
        }
    }

    var tvShowFromRealm: [ResultTvModel] {
        if realm.isEmpty {
            return Filtering.tvShow(tvShow, by: filteringMoviesIndex)
        } else {
            guard let tvShowFromRealm = FetchModelObject.forTvShow(from: realm, with: indexOfTvShowList) else { return Filtering.tvShow(tvShow, by: filteringMoviesIndex) }
            return Filtering.tvShow(Mappers.toResultTvModel(from: tvShowFromRealm), by: filteringMoviesIndex)
        }
    }

    init(indexOfTvShowList: TvShowList, filteringMoviesIndex: FilterMovies) {
        self.indexOfTvShowList = indexOfTvShowList
        self.filteringMoviesIndex = filteringMoviesIndex

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

enum TvShowList {
    case airingToday
    case onTheAir
    case popularTV
    case topRatedTV
}
