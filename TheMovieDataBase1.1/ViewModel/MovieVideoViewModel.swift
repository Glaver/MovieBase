//
//  MovieVideoViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import WebKit
import UIKit

class MovieVideoViewModel: ObservableObject {
    @Published var movieId: Int = 0
    @Published var trailerError: Errors?
    @Published var videos = [MovieVideoResult]()
    let endpoint: Endpoint

    init(movieId: Int, endpoint: Endpoint) {
        self.movieId = movieId
        self.endpoint = endpoint
        $movieId
            .setFailureType(to: Errors.self)
            .flatMap { (_) -> AnyPublisher<[MovieVideoResult], Errors> in
                FetchData.shared.fetchVideosError(fromEndpoint: endpoint)
                    .eraseToAnyPublisher()
            } // some how make it more simple
            .sink(receiveCompletion: { [unowned self] (completion) in
                    if case let .failure(error) = completion {
                        self.trailerError = error
                    }},
                  receiveValue: { [unowned self] in
                    self.videos = $0
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

/*            .flatMap { (movieId) -> AnyPublisher<[MovieVideoResult], Never> in
 FetchData.shared.fetchVideos(for: Endpoint.videos(movieID: movieId).finalURL)
}
.assign(to: \.videos, on: self)
.store(in: &self.cancellableSet)
}*/
