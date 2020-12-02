//
//  ImageViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 31/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

protocol ImageLoaderServiceProtocol {
    var image: UIImage? { get }
    var url: URL? { get }
}

class ImageLoaderService: ObservableObject {
    @Published var image: UIImage?
    @Published var url: String?
    var imageSize: ImageAPI.Size
    func assemblyURL(url: String?, size: ImageAPI.Size) -> URL? {
        return size.path(poster: url)
    }
    init(url: String?, imageSize: ImageAPI.Size) {
        self.url = url
        self.imageSize = imageSize
        $url
            .flatMap { (_) -> AnyPublisher<UIImage?, Never> in self.fetchImage(for: self.assemblyURL(url: url, size: imageSize)) }
            .assign(to: \.image, on: self)
            .store(in: &self.cancellationSet)
    }

    var cancellationSet: Set<AnyCancellable> = []

    deinit {
        for cancel in cancellationSet {
            cancel.cancel()
        }
    }

    func fetchImage(for url: URL?) -> AnyPublisher<UIImage?, Never> {
        guard url != nil, image == nil else {
            return Just(nil).eraseToAnyPublisher()
        }
        return
            URLSession.shared.dataTaskPublisher(for: url!)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
    }
}
