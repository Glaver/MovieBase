//
//  NetworkAPI.swift
//  TheMovieDataBase 1.0
//
//  Created by Vladyslav on 29/7/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine

public struct NetworkAPI {
    static let apiKey: String = "91d8fd603d3a00e0197c9b87f99559f4"
    
    static let jsonDecoder: JSONDecoder = {
           let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
}

class ImageAPI {
    static let shared = ImageAPI()
    
    enum Size: String {
        case original = "https://image.tmdb.org/t/p/original/"
        case medium = "https://image.tmdb.org/t/p/w500/"
        case cast = "https://image.tmdb.org/t/p/w185/"
        case small = "https://image.tmdb.org/t/p/154/"
        
        func path(poster: String?) -> URL? {
            return (poster != nil && poster != "null")
                ? URL(string: rawValue)!.appendingPathComponent(poster!)
                : nil
        }
    }
}

enum Endpoint {
    case upcoming
    case nowPlaying
    case popular
    case topRated
    case movieGenres
    case search (searchString: String)
    case credits (movieID: Int)
    case videos (movieID: Int)
    
    var baseURLv3: URL { URL(string: "https://api.themoviedb.org/3")! }
    
    func path() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .nowPlaying:
            return "movie/now_playing"
        case .movieGenres:
            return "/genre/movie/list"
        case .search(_):
            return "/search/movie"
        case let .credits(movieID):
            return "movie/\(String(movieID))/credits"
        case let .videos(movieID):
            return "movie/\(String(movieID))/videos"
        }
    }
    
    var finalURL: URL? {
        let queryURL = baseURLv3.appendingPathComponent(self.path())
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil }
        switch self {
        case .search (let name):
            urlComponents.queryItems = [URLQueryItem(name: "query", value: name),
                                        URLQueryItem(name: "api_key", value: NetworkAPI.apiKey),
                                        URLQueryItem(name: "language", value: "en"),
                                        URLQueryItem(name: "region", value: "US"),
                                        URLQueryItem(name: "page", value: "1")]
        default:
             urlComponents.queryItems = [URLQueryItem(name: "api_key", value: NetworkAPI.apiKey),
                                         URLQueryItem(name: "language", value: "en"),
                                         URLQueryItem(name: "region", value: "US"),
                                         URLQueryItem(name: "page", value: "1")]
        }
        return urlComponents.url
    }
    
    init?(index: MoviesList) {
        switch index {
        case .nowPlaying: self = .nowPlaying
        case .popular: self = .popular
        case .upcoming: self = .upcoming
        case .topRated: self = .topRated
        }
    }
}






