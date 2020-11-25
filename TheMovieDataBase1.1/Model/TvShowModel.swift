//
//  TvShowDataModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 5/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//
import RealmSwift
import Foundation

struct TvShowsModel: Codable {
    let page: Int
    let results: [ResultTvModel]
    let totalResults: Int
    let totalPages: Int
}

struct ResultTvModel: Codable, MovieShowViewProtocol, FilterTvShowAndMovies {
    let posterPath: String?
    let popularity: Float
    let id: Int
    let backdropPath: String?
    let voteAverage: Float
    let overview: String
    let firstAirDate: Date
    let originCountry: [String]
    let genreIds: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name: String
    let originalName: String
    var posterFileManagerName: String { "\(id)poster" }
    var backdropFileManagerName: String { "\(id)backDrop" }
    var title: String { name }
    var releaseDate: Date { firstAirDate }
}
