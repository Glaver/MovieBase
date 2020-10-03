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

class ImageLoaderViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var url: URL?
    
    init(url: URL?) {
        self.url = url
        $url
            .flatMap{ (path) -> AnyPublisher<UIImage?, Never> in self.fetchImage(for: url) }
            .assign(to: \.image, on: self)
            .store(in: &self.cancellationSet)
    }
    
    var cancellationSet: Set<AnyCancellable> = []
    
    deinit {
        for cancell in cancellationSet {
            cancell.cancel()
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
