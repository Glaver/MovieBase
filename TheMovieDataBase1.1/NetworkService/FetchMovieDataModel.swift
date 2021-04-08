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

    var subscriptions = Set<AnyCancellable>()

    func fetch<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data}
            .decode(type: T.self, decoder: NetworkAPI.jsonDecoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
// MARK: Fetch MoviesModel
    func fetchMovies(from endpoint: Endpoint) -> AnyPublisher<[MovieModel], Never> {
        guard let url = endpoint.finalURL else {
            return Just([MovieModel]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: MovieDataDTO) -> [MovieModel] in
                response.results }
            .replaceError(with: [MovieModel]())
            .eraseToAnyPublisher()
    }
 //TvShowsModel //ResultTvModel
    func fetchTVshow(from endpoint: Endpoint) -> AnyPublisher<[ResultTvModel], Never> {
        guard let url = endpoint.finalURL else {
            return Just([ResultTvModel]()).eraseToAnyPublisher()
        }
        return fetch(url)
            .map { (response: TvShowsModel) -> [ResultTvModel] in
                response.results }
            .replaceError(with: [ResultTvModel]())
            .eraseToAnyPublisher()
    }

// MARK: Fetch Genres
    func fetchGenresError(from endpoint: Endpoint) -> AnyPublisher<[GenresDTO], Errors> {
        Future<[GenresDTO], Errors> { [unowned self] promise in
            guard let url = endpoint.finalURL else { //check for validation of url for nil, if nil error
                return promise(.failure(.urlError(URLError(.unsupportedURL))))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                //output (data: Data, response: URLResponse) and URLError
                .tryMap { (data, response) -> Data in //if response between 200...299 use only data or error
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw Errors.responseError(
                            (response as? HTTPURLResponse)?.statusCode ?? 500,
                            String(data: data, encoding: .utf8) ?? "")
                    }
                    return data
                } //Errors.responseError(((response as? HTTPURLResponse)?.statusCode ?? 500,String(data: data, encoding: .utf8) ?? ""))
                .decode(type: GenreDTO.self, decoder: NetworkAPI.jsonDecoder)//decode data to type
                .receive(on: RunLoop.main) //send results to main thread
                .sink(receiveCompletion: { (completion) in //subscribe on publisher
                    if case let .failure(error) = completion { //if receiveCompletion has error
                        switch error {                         //send it to promise(.failure)
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.decodingError(decodingError)))
                        case let apiError as Errors:
                            promise(.failure(apiError))
                        default: promise(.failure(.genericError))
                        }
                    }
                },
                receiveValue: { promise(.success($0.genres)) }) //Notificate about successful fetch data
                .store(in: &self.subscriptions)
        }
        .eraseToAnyPublisher() //erase type of publisher and return AnyPublisher
    }
// MARK: Fetch Videos
    func fetchVideosError(fromEndpoint: Endpoint) -> AnyPublisher<[MovieVideoResult], Errors> {
        Future<[MovieVideoResult], Errors> { [unowned self] promise in
            guard let url = fromEndpoint.finalURL else {
                return promise(.failure(.urlError(URLError(.unsupportedURL))))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                //output (data: Data, response: URLResponse) and URLError
                .tryMap { (data, response) -> Data in //if response between 200...299 use only data or error
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw Errors.responseError(
                            (response as? HTTPURLResponse)?.statusCode ?? 500,
                            String(data: data, encoding: .utf8) ?? "")
                    }
                    return data
                }
                .decode(type: MovieVideo.self, decoder: NetworkAPI.jsonDecoder)//decode data to type
                .receive(on: RunLoop.main) //send results to main thread
                .sink(receiveCompletion: { (completion) in //subscribe on publisher
                    if case let .failure(error) = completion { //if receiveCompletion has error
                        switch error {                         //send it to promise(.failure)
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.decodingError(decodingError)))
                        case let apiError as Errors:
                            promise(.failure(apiError))
                        default: promise(.failure(.genericError))
                        }
                    }
                },
                receiveValue: { promise(.success($0.results)) }) //notificate about successful fetch data
                .store(in: &self.subscriptions)
        }
        .eraseToAnyPublisher() //erase type of publisher and return AnyPublisher
    }

// MARK: Fetch MoviesModel with Errors
    func fetchMoviesError(from endpoint: Endpoint) -> AnyPublisher<[MovieModel], Errors> {
        Future<[MovieModel], Errors> { [unowned self] promise in
            guard let url = endpoint.finalURL else {
                return promise(.failure(.urlError(URLError(.unsupportedURL))))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                //output (data: Data, response: URLResponse) and URLError
                .tryMap { (data, response) -> Data in //if response between 200...299 use only data or error
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw Errors.responseError(
                            (response as? HTTPURLResponse)?.statusCode ?? 500,
                            String(data: data, encoding: .utf8) ?? "")
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
                        case let apiError as Errors:
                            promise(.failure(apiError))
                        default: promise(.failure(.genericError))
                        }
                    }
                },
                receiveValue: { promise(.success($0.results)) }) //notificate about successful fetch data
                .store(in: &self.subscriptions)
        }
        .eraseToAnyPublisher() //erase type of publisher and return AnyPublisher
    }
// MARK: Fetch TVShow with Errors
    func fetchTvShow(from endpoint: Endpoint) -> AnyPublisher<[ResultTvModel], Errors> {
        Future<[ResultTvModel], Errors> { [unowned self] promise in
            guard let url = endpoint.finalURL else {
                return promise(.failure(.urlError(URLError(.unsupportedURL))))
            }
            URLSession.shared.dataTaskPublisher(for: url)

                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw Errors.responseError(
                            (response as? HTTPURLResponse)?.statusCode ?? 500,
                            String(data: data, encoding: .utf8) ?? "")
                    }
                    return data
                }
                .decode(type: TvShowsModel.self, decoder: NetworkAPI.jsonDecoder)//decode data to type
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.decodingError(decodingError)))
                        case let apiError as Errors:
                            promise(.failure(apiError))
                        default: promise(.failure(.genericError))
                        }
                    }
                },
                receiveValue: { promise(.success($0.results)) })
                .store(in: &self.subscriptions)
        }
        .eraseToAnyPublisher()
    }
// MARK: Try generic for array vs results
    func fetchArrayResults<T: Codable & ResultProperty, R: Codable>(from endpoint: Endpoint, forType: T.Type) -> AnyPublisher<[R], Errors> {
        Future<[R], Errors> { [unowned self] promise in //, intsanceData: R,
            guard let url = endpoint.finalURL else {
                return promise(.failure(.urlError(URLError(.unsupportedURL))))
            }
            URLSession.shared.dataTaskPublisher(for: url)
                //output (data: Data, response: URLResponse) and URLError
                .tryMap { (data, response) -> Data in //if response between 200...299 use only data or error
                    guard let httpResponse = response as? HTTPURLResponse,
                          200...299 ~= httpResponse.statusCode else {
                        throw Errors.responseError(
                            (response as? HTTPURLResponse)?.statusCode ?? 500,
                            String(data: data, encoding: .utf8) ?? "")
                    }
                    return data
                }
                .decode(type: T.self, decoder: NetworkAPI.jsonDecoder)//decode data to type
                .receive(on: RunLoop.main) //send results to main thread
                .sink(receiveCompletion: { (completion) in //subscribe on publisher
                    if case let .failure(error) = completion { //if receiveCompletion has error
                        switch error {                         //send it to promise(.failure)
                        case let urlError as URLError:
                            promise(.failure(.urlError(urlError)))
                        case let decodingError as DecodingError:
                            promise(.failure(.decodingError(decodingError)))
                        case let apiError as Errors:
                            promise(.failure(apiError))
                        default: promise(.failure(.genericError))
                        }
                    }
                },
                receiveValue: { promise(.success($0.results as! [R])) }) //notificate about successful fetch data
                .store(in: &self.subscriptions)
        }
        .eraseToAnyPublisher() //erase type of publisher and return AnyPublisher
    }
    // MARK: Recive generic data
    func fetchInstance<T: Codable>(for intsance: T, endpoint: Endpoint) -> AnyPublisher<T, Errors> {
            Future<T, Errors> { [unowned self] promise in //from id: Int
                guard let url = endpoint.finalURL else {
                    return promise(.failure(.urlError(URLError(.unsupportedURL))))
                }
                //debugPrint(url)
                URLSession.shared.dataTaskPublisher(for: url)
                    .tryMap { (data, response) -> Data in //if response between 200...299 use only data or error
                        guard let httpResponse = response as? HTTPURLResponse,
                              200...299 ~= httpResponse.statusCode else {
                            throw Errors.responseError(
                                (response as? HTTPURLResponse)?.statusCode ?? 500,
                                String(data: data, encoding: .utf8) ?? "")
                        }
                        return data
                    }
                    .decode(type: T.self, decoder: NetworkAPI.jsonDecoder)
                    .receive(on: RunLoop.main)
                    .sink(receiveCompletion: { (completion) in //subscribe on publisher
                        if case let .failure(error) = completion { //if receiveCompletion has error
                            switch error {                         //send it to promise(.failure)
                            case let urlError as URLError:
                                promise(.failure(.urlError(urlError)))
                            case let decodingError as DecodingError:
                                promise(.failure(.decodingError(decodingError)))
                            case let apiError as Errors:
                                promise(.failure(apiError))
                            default: promise(.failure(.genericError))
                            }
                        }
                    },
                    receiveValue: { promise(.success($0)) }) //notificate about successful fetch data
                    .store(in: &self.subscriptions)
            }
            .eraseToAnyPublisher() //erase type of publisher and return AnyPublisher
        }
}

protocol MovieResultsProperty {
    var results: [MovieModel] { get set }
}
protocol TvShowResultsProperty {
    var results: [ResultTvModel] { get set }
}
protocol VideoResultsProperty {
    var results: [MovieVideoResult] { get set }
}

typealias ResultProperty = MovieResultsProperty// & TvShowResultsProperty & VideoResultsProperty
