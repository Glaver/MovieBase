//
//  FetchMovieModelData.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 13/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final class FetchData {
    public static let shared = FetchData()
    
    func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
            .decode(type: T.self, decoder: NetworkAPI.jsonDecoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(from endpoint: Endpoint) -> AnyPublisher<[ResultDTO], Never> {
        guard let url = endpoint.finalURL else {
            return Just([ResultDTO]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: MovieDataDTO) -> [ResultDTO] in
                response.results }
            .replaceError(with: [ResultDTO]())
            
            .eraseToAnyPublisher()
    }
    
    func fetchGenres(from endpoint: Endpoint) -> AnyPublisher<[GenresDTO], Never> {
        guard let url = endpoint.finalURL else {
            return Just([GenresDTO]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: GenreDTO) -> [GenresDTO] in response.genres }
            .replaceError(with: [GenresDTO]())
            .eraseToAnyPublisher()
    }
    
        func fetchCredits(for movieID: Int) -> AnyPublisher<[MovieCast], Never> {
                guard let url =
                    Endpoint.credits(movieID: movieID).finalURL else {
                        return Just([MovieCast]()).eraseToAnyPublisher()
                }
                return
                    fetch(url)
                        .map { (response: MovieCreditResponse) -> [MovieCast] in
                            response.cast}
                        .replaceError(with: [MovieCast]())
                        .eraseToAnyPublisher()
        }
}
