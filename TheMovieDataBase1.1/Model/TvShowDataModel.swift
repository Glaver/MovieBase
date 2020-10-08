//
//  TvShowDataModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 5/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//
import RealmSwift
import Foundation

struct TvShowsDTO: Codable {
    let page: Int
    let results: [ResultTvDTO]
    let totalResults: Int
    let totalPages: Int
}

struct ResultTvDTO: Codable {
    let posterPath: String?
    let popularity: Int
    let id: Int
    let backdropPath: String?
    let voteAverage: Int
    let overview: String
    let firstAirDate: String
    let originCountry: [String]
    let genreIds: [Int]
    let originalLanguage: String
    let voteCount: Int
    let name: String
    let originalName: String
}

class TvShowObject: Object {
    @objc dynamic var posterPath: String? = nil
    @objc dynamic var popularity: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath: String? = nil
    @objc dynamic var voteAverage: Int = 0
    @objc dynamic var overview: String = ""
    @objc dynamic var firstAirDate: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var originalName: String = ""
    
    let originCountry = List<String>()
    let genreIds = List<Int>()
}
