//
//  RealmDataBase.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 29/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import RealmSwift

struct SaveModelObject {
// MARK: Save Movie Model to Realm
    static func forMovies(from listMovieModel: List<MovieModelObject>, to realm: Realm, with indexOfMoviesList: MoviesList) {
        try! realm.write {
            switch indexOfMoviesList {
            case .nowPlaying: realm.create(MoviesDataBase.self, value: ["id": 0, "nowPlying": listMovieModel], update: .modified)
            case .popular: realm.create(MoviesDataBase.self, value: ["id": 0, "popular": listMovieModel], update: .modified)
            case .upcoming: realm.create(MoviesDataBase.self, value: ["id": 0, "upcoming": listMovieModel], update: .modified)
            case .topRated: realm.create(MoviesDataBase.self, value: ["id": 0, "topRated": listMovieModel], update: .modified)
            }
        }
    }
// MARK: Save Movie Details to Realm
    static func forMovieDetails(from movieDetailObject: MovieDetailObject, to realm: Realm) {
        try! realm.write{
            realm.add(movieDetailObject, update: .modified)
        }
    }
// MARK: Save Movie Cast to Realm
    static func forCast(from movieCast: [MovieCastObject], to realm: Realm) {
        movieCast.forEach{cast in
            try! realm.write{
                realm.add(cast, update: .modified)
            }
        }
    }
// MARK: Save Movie Genres to Realm
    static func forGenres(from genresDTO: [GenresDTO], to realm: Realm) {
        genresDTO.forEach { ganre in
            let ganres = GenresObject()
            
            ganres.id = ganre.id
            ganres.name = ganre.name
            
            try! realm.write{
                realm.add(ganres, update: .modified)
            }
        }
    }
}

struct FetchModelObject {
// MARK: Load Movie Model from Realm
    static func forMovies(from realm: Realm, with indexOfMoviesList: MoviesList) -> [MovieModel] {
        let movies = realm.object(ofType: MoviesDataBase.self, forPrimaryKey: 0)
        var arrayOfMovies = [MovieModel]()
        
        switch indexOfMoviesList {
        case .nowPlaying: arrayOfMovies = Mappers.toMovieModel(from: Array(movies!.nowPlying))
        case .popular: arrayOfMovies = Mappers.toMovieModel(from: Array(movies!.popular))
        case .upcoming: arrayOfMovies = Mappers.toMovieModel(from: Array(movies!.upcoming))
        case .topRated: arrayOfMovies = Mappers.toMovieModel(from: Array(movies!.topRated))
        }
        return arrayOfMovies
    }
// MARK: Load Movie Details from Realm
    static func forMovieDetails(from realm: Realm, for movieId: Int) -> Results<MovieDetailObject> {
        let movieDetail: Results<MovieDetailObject> = realm.objects(MovieDetailObject.self).filter("id == \(movieId)")
        return movieDetail
    }
// MARK: Load Movie Cast from Realm
    static func forCast(from realm: Realm, for movieId: Int) -> Results<MovieCastObject> {
        let cast: Results<MovieCastObject> = realm.objects(MovieCastObject.self).filter("movieId == \(movieId)")
        return cast
    }
// MARK: Load Movie Genres from Realm
    static func forGenres(from realm: Realm) -> GenresDictionary {
        let genres: Results<GenresObject> = realm.objects(GenresObject.self)
        return Mappers.toGenresDictionary(from: genres)
    }
}
