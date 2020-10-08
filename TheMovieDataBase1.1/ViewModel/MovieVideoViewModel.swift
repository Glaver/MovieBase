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
    @Published var videos = [MovieVideoResult](){
        didSet {
            for video in videos{
                print(video.id)
                print(video.name)
                print(video.site)
                print(video.key)
                //print(videos.count)
            }
            //SaveModelObject.forGenres(from: genres, to: realm)
        }
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        $movieId
            .flatMap { (movieId) -> AnyPublisher<[MovieVideoResult], Never> in
                FetchData.shared.fetchVideos(for: movieId)
            }
            .assign(to: \.videos, on: self)
            .store(in: &self.cancellableSet)
    }
    private var cancellableSet: Set<AnyCancellable> = []
    
    deinit {
        for cancell in cancellableSet {
            cancell.cancel()
        }
    }
}
