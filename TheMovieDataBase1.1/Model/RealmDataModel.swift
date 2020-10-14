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
    @objc dynamic var releaseDate: Date = Date.init("2020-10-09")
    @objc dynamic var rating: Float = 0
    
    let genres = List<Int>()
    
    override static func primaryKey() -> String? {
            return "id"
        }
    
    convenience init(popularity: Float, id: Int, title: String, backdropPosterPath: String?, posterPath: String?, overview: String, releaseDate: Date, rating: Float) {
        self.init()
        self.popularity = popularity
        self.id = id
        self.title = title
        self.backdropPosterPath = backdropPosterPath
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.rating = rating
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
    @objc dynamic var movieId: Int  = 0
    @objc dynamic var key: Int  = 0
    @objc dynamic var character: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var profilePath: String? = ""
    
    override static func primaryKey() -> String? {
        return "key"
    }

    
    convenience init(id: Int, movieId: Int, key: Int, character: String, profilePath: String?, name: String) {
        self.init()
        self.id = id
        self.movieId = movieId
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
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, department: String, job: String, name: String) {
        self.init()
        self.id = id
        self.department = department
        self.job = job
        self.name = name
    }
}

class MovieDetailObject: Object {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String? = nil
    //let belongsToCollection: [String?]
    @objc dynamic var budget: Int = 0
    //let genres: [GenresDTO]
    @objc dynamic var homepage: String? = nil
    @objc dynamic var id: Int = 0
    @objc dynamic var imdbId: String? = nil // minLength: 9 maxLength: 9 pattern: ^tt[0-9]{7}
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview: String? = nil
    @objc dynamic var popularity: Float = 0
    @objc dynamic var posterPath: String? = nil
    //let productionCompanies: [ProductionCompaniesModel]
    //let productionCountries = List<ProductionCountriesObject>()
    @objc dynamic var releaseDate: String = "" //format: date
    @objc dynamic var revenue: Int = 0
    dynamic var runtime: Int? = nil
    //let spokenLanguages: [SpokenLanguages]
    @objc dynamic var status: String = "" //Allowed Values: Rumored, Planned, In Production, Post Production, Released, Canceled
    @objc dynamic var tagline:String? = nil
    @objc dynamic var title: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Float = 0
    @objc dynamic var voteCount: Int = 0
    
    var posterFilemanagerName: String {
        return "\(id)poster"
    }
    var backdropFilemanagerName: String {
        return "\(id)backDrop"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(adult: Bool, backdropPath: String?, budget: Int, homepage: String?, id: Int, imdbId: String?, originalLanguage: String, originalTitle: String, overview: String?, popularity: Float, posterPath: String?, releaseDate: String, revenue: Int, runtime: Int?, status: String, tagline:String?, title: String, video: Bool, voteAverage: Float, voteCount: Int) {
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
        self.runtime = runtime
        //self.spokenLanguages = [SpokenLanguages(iso6391: "", name: "")]
        self.status = status //Allowed Values: Rumored, Planned, In Production, Post Production, Released, Canceled
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

class ProductionCompaniesModelObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String? = nil
    @objc dynamic var originCountry: String = ""
}

class ProductionCountriesObject: Object {
    @objc dynamic var iso31661: String = ""
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
    
    convenience init(iso31661: String, name: String){
        self.init()
        self.iso31661 = iso31661
        self.name = name
    }
}

class SpokenLanguagesObject: Object {
    @objc dynamic var iso6391: String = ""
    @objc dynamic var name: String = ""
}
