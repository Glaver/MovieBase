//
//  RealmDataBase.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 29/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

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
// MARK: Save TV show Model to Realm
    static func forTvShow(from listTvShowModel: List<TvShowObject>, to realm: Realm, with indexOfTvShowList: TvShowList) {
        try! realm.write {
            switch indexOfTvShowList {
            case .airingToday: realm.create(TvShowBase.self, value: ["id": 0, "airingToday": listTvShowModel], update: .modified)
            case .onTheAir: realm.create(TvShowBase.self, value: ["id": 0, "onTheAir": listTvShowModel], update: .modified)
            case .popularTV: realm.create(TvShowBase.self, value: ["id": 0, "popularTV": listTvShowModel], update: .modified)
            case .topRatedTV: realm.create(TvShowBase.self, value: ["id": 0, "topRatedTV": listTvShowModel], update: .modified)
            }
        }
    }
// MARK: Save Movie Details to Realm
    static func forMovieDetails(from movieDetailObject: MovieDetailObject, to realm: Realm) {
        try! realm.write {
            realm.add(movieDetailObject, update: .modified)
        }
    }
// MARK: Save Movie Details to Realm
    static func forTvShowDetails(from tvShowDetail: TvShowDetailObject, to realm: Realm) {
        try! realm.write {
            realm.add(tvShowDetail, update: .modified)
        }
    }
// MARK: Save Movie Cast to Realm
    static func forCast(from movieCast: [MovieCastObject], to realm: Realm) {
        movieCast.forEach {cast in
            try! realm.write {
                realm.add(cast, update: .modified)
            }
        }
    }

// MARK: Save Movie Credits to Realm
    static func forCredits(from listCredits: (List<MovieCastObject>, List<MovieCrewObject>), to realm: Realm, with movieID: Int) {
        try! realm.write {
            realm.create(MovieCreditObject.self, value: ["id": movieID, "cast": listCredits.0, "crew": listCredits.1], update: .modified)
        }
    }
// MARK: Save Movie Genres to Realm
    static func forGenres(from genresDTO: [GenresDTO], to realm: Realm) {
        genresDTO.forEach { genre in
            let genres = GenresObject()

            genres.id = genre.id
            genres.name = genre.name

            try! realm.write {
                realm.add(genres, update: .modified)
            }
        }
    }
}

struct FetchModelObject {
// MARK: Load Movie Model from Realm
    static func forMovies(from realm: Realm, with indexOfMoviesList: MoviesList) -> List<MovieModelObject>? {
        let movies = realm.object(ofType: MoviesDataBase.self, forPrimaryKey: 0)
        var arrayOfMovies: List<MovieModelObject>?

        switch indexOfMoviesList {
        case .nowPlaying: arrayOfMovies = movies?.nowPlying
        case .popular: arrayOfMovies = movies?.popular
        case .upcoming: arrayOfMovies = movies?.upcoming
        case .topRated: arrayOfMovies = movies?.topRated
        }
        return arrayOfMovies
    }
// MARK: Load TV show Model from Realm
    static func forTvShow(from realm: Realm, with indexOfTvShowList: TvShowList) -> List<TvShowObject>? {
        let movies = realm.object(ofType: TvShowBase.self, forPrimaryKey: 0)
        var arrayOfOfTvShow: List<TvShowObject>?

        switch indexOfTvShowList {
        case .airingToday: arrayOfOfTvShow = movies?.airingToday
        case .onTheAir: arrayOfOfTvShow = movies?.onTheAir
        case .popularTV: arrayOfOfTvShow = movies?.popularTV
        case .topRatedTV: arrayOfOfTvShow = movies?.topRatedTV
        }
        return arrayOfOfTvShow
    }
// MARK: Load Movie Details from Realm
    static func forMovieDetails(from realm: Realm, for movieId: Int) -> Results<MovieDetailObject> {
        let movieDetail: Results<MovieDetailObject> = realm.objects(MovieDetailObject.self).filter("id == \(movieId)")
        return movieDetail
    }
// MARK: Load Movie Details from Realm
    static func forTvShowDetails(from realm: Realm, for tvShowId: Int) -> Results<TvShowDetailObject> {
        let tvShowDetail: Results<TvShowDetailObject> = realm.objects(TvShowDetailObject.self).filter("id == \(tvShowId)")
        return tvShowDetail
    }
// MARK: Load Movie Cast from Realm
    static func forCast(from realm: Realm, for movieId: Int) -> Results<MovieCastObject> {
        let cast: Results<MovieCastObject> = realm.objects(MovieCastObject.self).filter("movieId == \(movieId)")
        return cast
    }
// MARK: Load MovieCreditResponse from Realm
    static func forCredits(from realm: Realm, for movieId: Int) -> Results<MovieCreditObject> {
        let credits: Results<MovieCreditObject> = realm.objects(MovieCreditObject.self).filter("id == \(movieId)")
        return credits
    }
// MARK: Load Movie Genres from Realm
    static func forGenres(from realm: Realm) -> GenresDictionary {
        let genres: Results<GenresObject> = realm.objects(GenresObject.self)
        return Mappers.toGenresDictionary(from: genres)
    }
}
