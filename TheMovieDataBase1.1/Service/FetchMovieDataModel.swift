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
// MARK: Fetch MoviesModel
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
// MARK: Fetch Genres
    func fetchGenres(from endpoint: Endpoint) -> AnyPublisher<[GenresDTO], Never> {
        guard let url = endpoint.finalURL else {
            return Just([GenresDTO]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: GenreDTO) -> [GenresDTO] in response.genres }
            .replaceError(with: [GenresDTO]())
            .eraseToAnyPublisher()
    }
// MARK: Fetch Credits
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
// MARK: Fetch Videos
    func fetchVideos(for movieID: Int) -> AnyPublisher<[MovieVideoResult], Never> {
            guard let url =
                Endpoint.videos(movieID: movieID).finalURL else {
                    return Just([MovieVideoResult]()).eraseToAnyPublisher()
            }
            return
                fetch(url)
                    .map { (response: MovieVideo) -> [MovieVideoResult] in
                        response.results}
                    .replaceError(with: [MovieVideoResult]())
                    .eraseToAnyPublisher()
    }
// MARK: Fetch MoviesDetail
    func fetchMovieDetail(for movieID: Int) -> AnyPublisher<MovieDetailModel, Never> {
            guard let url =
                Endpoint.movieDetail(movieID: movieID).finalURL else {
                    return Just(MovieDetailModel()).eraseToAnyPublisher()
            }
            return
                fetch(url)
                    .map { $0 }
                    .replaceError(with: MovieDetailModel())
                    .eraseToAnyPublisher()
    }
  
// MARK: Fetch MoviesModel with Errors
    var subscriptions = Set<AnyCancellable>()
    func fetchMoviesError(from endpoint: Endpoint) -> AnyPublisher<[ResultDTO], MoviesError> {
        Future<[ResultDTO], MoviesError> { [unowned self] promise in
            guard let url = endpoint.finalURL else { //check for validation of url for nil, if nil error
                return promise(.failure(.urlError(URLError(.unsupportedURL))))
            }
            
            URLSession.shared.dataTaskPublisher(for: url)
                //output (data: Data, response: URLResponse) and URLError
                .tryMap{ (data, response) -> Data in //if response betwen 200...299 use only data or error
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw MoviesError.responseError(
                        ((response as? HTTPURLResponse)?.statusCode ?? 500,
                         String(data: data, encoding: .utf8) ?? ""))
                    }
                    return data
                }
                .decode(type: MovieDataDTO.self, decoder: NetworkAPI.jsonDecoder)//decode data to type
                .receive(on: RunLoop.main) //send results to main thread
                .sink(receiveCompletion: { (completion) in //subscribe on publisher
                    if case let .failure(error) = completion { //if receiveCompletion has error
                        switch error {                         //send it to promise(.failure)
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.decodingError(decodingError)))
                        case let apiError as MoviesError:
                            promise(.failure(apiError))
                        default: promise(.failure(.genericError))
                        }
                    }
                },
                receiveValue: { promise(.success($0.results)) }) //notificate about successful fecth data
                .store(in: &self.subscriptions)
        }
        .eraseToAnyPublisher() //erase type of publisher and return AnyPublisher
    }
}
// MARK: Enum MoviesError
enum MoviesError: Error, LocalizedError, Identifiable {
    var id: String { localizedDescription }
    case urlError(URLError)
    case responseError((Int, String))
    case decodingError(DecodingError)
    case genericError
}
