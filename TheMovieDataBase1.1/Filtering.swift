//
//  Filtering.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 26/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

protocol FilterTvShowAndMovies {
    var releaseDate: Date { get }
    var title: String { get }
    var voteAverage: Float { get }
    var popularity: Float { get }
}

protocol FilterContentProtocol {
    func listOfContent(_ array: [FilterTvShowAndMovies], by filteringTvShowIndex: FilterContent.FilteredParameters) -> [FilterTvShowAndMovies]
}

class FilterContent: FilterContentProtocol {
    enum FilteredParameters {
        case popularity
        case releaseDate
        case title
        case rating
    }

    func listOfContent(_ array: [FilterTvShowAndMovies], by filteringTvShowIndex: FilteredParameters) -> [FilterTvShowAndMovies] {
        var filteredMovies = array
        switch filteringTvShowIndex {
        case .releaseDate: filteredMovies = array.sorted { $0.releaseDate > $1.releaseDate }
        case .title: filteredMovies = array.sorted { $0.title < $1.title }
        case .rating: filteredMovies = array.sorted { $0.voteAverage > $1.voteAverage }
        case .popularity: filteredMovies = array.sorted { $0.popularity > $1.popularity }
        }
        return filteredMovies
    }
}
