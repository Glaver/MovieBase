//  DataModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 12/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import RealmSwift

class MoviesDataBase: Object {
    @objc dynamic var id: Int = 0

    let nowPlying = List<MovieModelObject>()
    let popular   = List<MovieModelObject>()
    let upcoming  = List<MovieModelObject>()
    let topRated  = List<MovieModelObject>()

    override static func primaryKey() -> String? {
            return "id"
        }
}

class MovieModelObject: Object {
    @objc dynamic var popularity: Float = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var backdropPosterPath: String? = ""
    @objc dynamic var posterPath: String? = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: Date = Date()
    @objc dynamic var voteAverage: Float = 0

    let genres = List<Int>()

    override static func primaryKey() -> String? {
            return "id"
        }

    convenience init(popularity: Float, id: Int, title: String, backdropPosterPath: String?, posterPath: String?, overview: String, releaseDate: Date, voteAverage: Float) {
        self.init()
        self.popularity = popularity
        self.id = id
        self.title = title
        self.backdropPosterPath = backdropPosterPath
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
}

class GenresObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}

class MovieCreditObject: Object {
    @objc dynamic var id: Int = 0
    let cast = List<MovieCastObject>()
    let crew = List<MovieCrewObject>()

    override static func primaryKey() -> String? {
        return "id"
    }
}

class MovieCastObject: Object {
    @objc dynamic var id: Int  = 0
    //@objc dynamic var movieId: Int  = 0
    @objc dynamic var key: Int  = 0
    @objc dynamic var character: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var profilePath: String? = ""

    override static func primaryKey() -> String? {
        return "key"
    }

    convenience init(id: Int, key: Int, character: String, profilePath: String?, name: String) {
        self.init()
        self.id = id
        //self.movieId = movieId  movieId: Int,
        self.key = key
        self.character = character
        self.profilePath = profilePath
        self.name = name
    }
}

class MovieCrewObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var department: String = ""
    @objc dynamic var job: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var key: Int  = 0

    override static func primaryKey() -> String? {
        return "key"
    }

    convenience init(id: Int, department: String, job: String, name: String, key: Int) {
        self.init()
        self.id = id
        self.department = department
        self.job = job
        self.name = name
        self.key = key
    }
}

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
    @objc dynamic var releaseDate: Date = Date() //format: date
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

class ProductionCompaniesObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String?
    @objc dynamic var originCountry: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(name: String, id: Int, logoPath: String?, originCountry: String) {
        self.init()
        self.name = name
        self.id = id
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
}

class ProductionCountriesObject: Object {
    @objc dynamic var iso31661: String = ""
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "name"
    }

    convenience init(iso31661: String, name: String) {
        self.init()
        self.iso31661 = iso31661
        self.name = name
    }
}

class SpokenLanguagesObject: Object {
    @objc dynamic var iso6391: String = ""
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "name"
    }

    convenience init(iso6391: String, name: String) {
        self.init()
        self.iso6391 = iso6391
        self.name = name
    }
}
