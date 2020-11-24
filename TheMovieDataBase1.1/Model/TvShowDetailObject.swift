//
//  TvShowDetailObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class TvShowDetailObject: Object {
    @objc dynamic var backdropPath: String? = ""
    let createdBy = List<CreatedByObject>()
    let episodeRunTime = List<Int>()
    @objc dynamic var firstAirDate: Date = Date()
    let genres = List<GenresObject>()
    @objc dynamic var homepage: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var inProduction: Bool = false
    let languages = List<String>()
    @objc dynamic var lastAirDate: Date = Date()
//    let lastEpisodeToAir = List<EpisodeObject>()
    @objc dynamic var name: String = ""
//    @objc dynamic var nextEpisodeToAir: String? = ""
    let networks = List<NetworksObject>()
    @objc dynamic var numberOfEpisodes: Int = 0
    @objc dynamic var numberOfSeasons: Int = 0
    let originCountry = List<String>()
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalName: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Float = 0
    @objc dynamic var posterPath: String? = ""
    let productionCompanies = List<ProductionCompaniesObject>()
    let seasons = List<SeasonsObject>()
    @objc dynamic var status: String = ""
    @objc dynamic var tagline: String? = ""
    @objc dynamic var type: String = ""
    @objc dynamic var voteAverage: Float = 0
    @objc dynamic var voteCount: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(backdropPath: String?,
                     firstAirDate: Date,
                     homepage: String,
                     id: Int,
                     inProduction: Bool,
                     lastAirDate: Date,
                     name: String,
//                     nextEpisodeToAir: String?,
                     numberOfEpisodes: Int,
                     numberOfSeasons: Int,
                     originalLanguage: String,
                     originalName: String,
                     overview: String,
                     popularity: Float,
                     posterPath: String?,
                     status: String,
                     tagline: String,
                     type: String,
                     voteAverage: Float,
                     voteCount: Int) {
        self.init()
        self.backdropPath = backdropPath
        self.firstAirDate = firstAirDate
        self.homepage = homepage
        self.id = id
        self.inProduction = inProduction
        self.lastAirDate = lastAirDate
        self.name = name
 //       self.nextEpisodeToAir = nextEpisodeToAir
        self.numberOfEpisodes = numberOfEpisodes
        self.numberOfSeasons = numberOfSeasons
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.status = status
        self.tagline = tagline
        self.type = type
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

class CreatedByObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var creditId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var gender: Int = 0
    @objc dynamic var profilePath: String? = ""

    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: Int,
                     creditId: String,
                     name: String,
                     gender: Int,
                     profilePath: String) {
        self.init()
        self.id = id
        self.creditId = creditId
        self.name = name
        self.gender = gender
        self.profilePath = profilePath
    }
}

class EpisodeObject: Object {
    @objc dynamic var airDate: Date = Date()
    @objc dynamic var episodeNumber: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var productionCode: String = ""
    @objc dynamic var seasonNumber: Int = 0
    @objc dynamic var showId: Int = 0
    @objc dynamic var stillPath: String = ""
    @objc dynamic var voteAverage: Float = 0
    @objc dynamic var voteCount: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(airDate: Date,
                     episodeNumber: Int,
                     id: Int,
                     name: String,
                     overview: String,
                     productionCode: String,
                     seasonNumber: Int,
                     showId: Int,
                     stillPath: String,
                     voteAverage: Float,
                     voteCount: Int) {
        self.init()
        self.airDate = airDate
        self.episodeNumber = episodeNumber
        self.id = id
        self.name = name
        self.overview = overview
        self.productionCode = productionCode
        self.seasonNumber = seasonNumber
        self.showId = showId
        self.stillPath = stillPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

class NetworksObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String = ""
    @objc dynamic var originCountry: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(name: String,
                     id: Int,
                     logoPath: String,
                     originCountry: String) {
        self.init()
        self.name = name
        self.id = id
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
}

class SeasonsObject: Object {
    @objc dynamic var airDate: Date? = Date()
    @objc dynamic var episodeCount: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var seasonNumber: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(airDate: Date,
                     episodeCount: Int,
                     id: Int,
                     name: String,
                     overview: String,
                     posterPath: String,
                     seasonNumber: Int) {
        self.init()
        self.airDate = airDate
        self.episodeCount = episodeCount
        self.id = id
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.seasonNumber = seasonNumber
    }
}
