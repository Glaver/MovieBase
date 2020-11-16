//
//  Filtering.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 26/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

struct Filtering {
    static func movies(_ array: [MovieModel], by filteringMoviesIndex: FilterMovies) -> [MovieModel] {
        var filteredMovies = [MovieModel]()
        switch filteringMoviesIndex {
        case .releaseDate: filteredMovies = array.sorted { $0.releaseDate > $1.releaseDate }
        case .title: filteredMovies = array.sorted { $0.title < $1.title }
        case .rating: filteredMovies = array.sorted { $0.voteAverage > $1.voteAverage }
        case .popularity: filteredMovies = array.sorted { $0.popularity > $1.popularity }
        }
        return filteredMovies
    }

    static func tvShow(_ array: [ResultTvModel], by filteringTvShowIndex: FilterMovies) -> [ResultTvModel] {
        var filteredMovies = [ResultTvModel]()
        switch filteringTvShowIndex {
        case .releaseDate: filteredMovies = array.sorted { $0.releaseDate > $1.releaseDate }
        case .title: filteredMovies = array.sorted { $0.title < $1.title }
        case .rating: filteredMovies = array.sorted { $0.voteAverage > $1.voteAverage }
        case .popularity: filteredMovies = array.sorted { $0.popularity > $1.popularity }
        }
        return filteredMovies
    }
}

enum FilterMovies {
    case popularity
    case releaseDate
    case title
    case rating
}

protocol FilterTvShowAndMovies {
    var releaseDate: Date { get }
    var title: String { get }
    var voteAverage: Float { get }
    var popularity: Float { get }
}
