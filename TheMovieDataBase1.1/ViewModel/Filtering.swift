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
        case .releaseDate: filteredMovies = array.sorted{ $0.releaseDate > $1.releaseDate }
        case .title: filteredMovies = array.sorted{ $0.title < $1.title }
        case .rating: filteredMovies = array.sorted{ $0.rating > $1.rating }
        }
        return filteredMovies
    }
}

enum MoviesList {
    case nowPlaying
    case popular
    case upcoming
    case topRated
}

enum FilterMovies {
    case releaseDate
    case title
    case rating
}
