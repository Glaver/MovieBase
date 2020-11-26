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
    enum CategoryVideo { case movie, tvShow }
    @Published var movieId: Int = 0
    @Published var trailerError: Errors?
    @Published var videos = [MovieVideoResult]()
    var videoContentFor: CategoryVideo = .movie
    private func chooseEndpoint(endpoint: CategoryVideo, id: Int) -> Endpoint {
        switch endpoint {
        case .movie: return Endpoint.videos(movieID: id)
        case .tvShow: return Endpoint.videosTV(tvShowID: id)
        }
    }
    init(movieId: Int, videoContentFor: CategoryVideo) {
        self.movieId = movieId
        self.videoContentFor = videoContentFor
        $movieId
            .setFailureType(to: Errors.self)
            .flatMap { (_) -> AnyPublisher<[MovieVideoResult], Errors> in
                FetchData.shared.fetchVideosError(fromEndpoint: self.chooseEndpoint(endpoint: self.videoContentFor, id: movieId))
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
