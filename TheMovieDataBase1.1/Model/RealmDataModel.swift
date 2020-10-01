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
    
    convenience init(id: Int, title: String, backdropPosterPath: String?, posterPath: String?, overview: String, releaseDate: Date, rating: Float) {
        self.init()
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
