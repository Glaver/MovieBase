//
//  TvShowObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

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
