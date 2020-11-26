//
//  MovieDetailObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class MovieDetailObject: Object {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String?
    //let belongsToCollection: [String?]
    @objc dynamic var budget: Int = 0
    let genres = List<GenresObject>()
    @objc dynamic var homepage: String?
    @objc dynamic var id: Int = 0
    @objc dynamic var imdbId: String? // minLength: 9 maxLength: 9 pattern: ^tt[0-9]{7}
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String?
    @objc dynamic var popularity: Float = 0
    @objc dynamic var posterPath: String?
    let productionCompanies = List<ProductionCompaniesObject>()
    let productionCountries = List<ProductionCountriesObject>()
    @objc dynamic var releaseDate: Date = Date()
    @objc dynamic var revenue: Int = 0
    let runtime = RealmOptional<Int>()
    let spokenLanguages = List<SpokenLanguagesObject>()
    @objc dynamic var status: String = "" //Allowed Values: Rumored, Planned, In Production, Post Production, Released, Canceled
    @objc dynamic var tagline: String?
    @objc dynamic var title: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Float = 0
    @objc dynamic var voteCount: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(adult: Bool,
                     backdropPath: String?,
                     budget: Int,
                     homepage: String?,
                     id: Int,
                     imdbId: String?,
                     originalLanguage: String,
                     originalTitle: String,
                     overview: String?,
                     popularity: Float,
                     posterPath: String?,
                     releaseDate: Date,
                     revenue: Int,
                     status: String,
                     tagline: String?,
                     title: String,
                     video: Bool,
                     voteAverage: Float,
                     voteCount: Int) {//, runtime: Int?
        self.init()
        self.adult = adult
        self.backdropPath = backdropPath
        //let belongsToCollection: [String?]
        self.budget = budget
        //self.genres = [GenresDTO(id: 0, name: "")]
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId // minLength: 9 maxLength: 9 pattern: ^tt[0-9]{7}
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate //format: date
        self.revenue = revenue
        //self.runtime = runtime
        //self.spokenLanguages = [SpokenLanguages(iso6391: "", name: "")]
        self.status = status //Allowed Values: Rumored, Planned, In Production, Post Production, Released, Canceled
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
