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

struct ResultTvModel: Codable, MovieShowViewProtocol {
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

    var posterFileManagerName: String {
        return "\(id)poster"
    }
    var backdropFileManagerName: String {
        return "\(id)backDrop"
    }

    var title: String { return name }
    var backdropPosterPath: String? { return backdropPath }
    var releaseDate: Date { return firstAirDate }
    var genres: [Int] { return genreIds }
}

class TvShowBase: Object {
    @objc dynamic var id: Int = 0

    let airingToday = List<TvShowObject>()
    let onTheAir    = List<TvShowObject>()
    let popularTV   = List<TvShowObject>()
    let topRatedTV  = List<TvShowObject>()

    override static func primaryKey() -> String? {
            return "id"
        }
}

class TvShowObject: Object {
    @objc dynamic var posterPath: String?
    @objc dynamic var popularity: Float = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath: String?
    @objc dynamic var voteAverage: Float = 0
    @objc dynamic var overview: String = ""
    @objc dynamic var firstAirDate: Date = Date()
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var originalName: String = ""

    let originCountry = List<String>()
    let genreIds = List<Int>()

    override static func primaryKey() -> String? {
            return "id"
        }

    convenience init(posterPath: String?,
                     popularity: Float,
                     id: Int,
                     backdropPath: String?,
                     voteAverage: Float,
                     overview: String,
                     firstAirDate: Date,
                     originalLanguage: String,
                     voteCount: Int,
                     name: String,
                     originalName: String) {
        self.init()
        self.posterPath = posterPath
        self.popularity = popularity
        self.id = id
        self.backdropPath = backdropPath
        self.voteAverage = voteAverage
        self.overview = overview
        self.firstAirDate = firstAirDate
        self.originalLanguage = originalLanguage
        self.voteCount = voteCount
        self.name = name
        self.originalName = originalName
    }
}
