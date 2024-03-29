//
//  SearchMovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 27/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine

final class SearchMovieViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var searchError: Errors?
    @Published var moviesDTO = [MovieModel]()
    init() {
 //       if contentType == .movie {
            $name
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .removeDuplicates()
                .flatMap { name -> AnyPublisher<[MovieModel], Never> in
                    Future<[MovieModel], Never> { (promise) in
                        if 2...30 ~= name.count {
                            FetchData.shared.fetchMovies(from: Endpoint.search(searchString: name))
                                .sink(receiveValue: {value in promise(.success(value)) })
                                .store(in: &self.cancellableSet)
                        } else {
                            promise(.success([MovieModel]()))
                        }
                    }
                    .eraseToAnyPublisher()
                }
                .assign(to: \.moviesDTO, on: self)
                .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancel in cancellableSet {
            cancel.cancel()
        }
    }
}

final class SearchTvShowViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var searchError: Errors?
    @Published var tvShow = [ResultTvModel]()
    init() {
        $name
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { name -> AnyPublisher<[ResultTvModel], Never> in
                Future<[ResultTvModel], Never> { (promise) in
                    if 2...30 ~= name.count {
                        FetchData.shared.fetchTVshow(from: Endpoint.searchTV(searchString: name))
                            .sink(receiveValue: {value in promise(.success(value)) })
                            .store(in: &self.cancellableSet)
                    } else {
                        promise(.success([ResultTvModel]()))
                    }
                }
                .eraseToAnyPublisher()
            }
            .assign(to: \.tvShow, on: self)
            .store(in: &self.cancellableSet)
    }
    //

    private var cancellableSet: Set<AnyCancellable> = []
    deinit {
        for cancel in cancellableSet {
            cancel.cancel()
        }
    }
}
