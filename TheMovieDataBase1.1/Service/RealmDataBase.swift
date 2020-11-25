//
//  RealmDataBase.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 29/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class MovieListRealm: MovieListRealmProtocol {
    // MARK: Save Movie Model to Realm
    func forMovies(from listMovieModel: List<MovieModelObject>, to realm: Realm, with indexOfMoviesList: MoviesList) {
        try! realm.write {
            switch indexOfMoviesList {
            case .nowPlaying: realm.create(MoviesDataBase.self, value: ["id": 0, "nowPlying": listMovieModel], update: .modified)
            case .popular: realm.create(MoviesDataBase.self, value: ["id": 0, "popular": listMovieModel], update: .modified)
            case .upcoming: realm.create(MoviesDataBase.self, value: ["id": 0, "upcoming": listMovieModel], update: .modified)
            case .topRated: realm.create(MoviesDataBase.self, value: ["id": 0, "topRated": listMovieModel], update: .modified)
            }
        }
    }
    // MARK: Load Movie Model from Realm
    func forMovies(from realm: Realm, with indexOfMoviesList: MoviesList) -> List<MovieModelObject>? {
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
}
protocol MovieListRealmProtocol {
    func forMovies(from listMovieModel: List<MovieModelObject>, to realm: Realm, with indexOfMoviesList: MoviesList)
    func forMovies(from realm: Realm, with indexOfMoviesList: MoviesList) -> List<MovieModelObject>?
}
    
class TvShowListRealm: TvShowListRealmProtocol {
    // MARK: Save TV show Model to Realm
    func forTvShow(from listTvShowModel: List<TvShowObject>, to realm: Realm, with indexOfTvShowList: TvShowList) {
        try! realm.write {
            switch indexOfTvShowList {
            case .airingToday: realm.create(TvShowBase.self, value: ["id": 0, "airingToday": listTvShowModel], update: .modified)
            case .onTheAir: realm.create(TvShowBase.self, value: ["id": 0, "onTheAir": listTvShowModel], update: .modified)
            case .popularTV: realm.create(TvShowBase.self, value: ["id": 0, "popularTV": listTvShowModel], update: .modified)
            case .topRatedTV: realm.create(TvShowBase.self, value: ["id": 0, "topRatedTV": listTvShowModel], update: .modified)
            }
        }
    }
    // MARK: Load TV show Model from Realm
    func forTvShow(from realm: Realm, with indexOfTvShowList: TvShowList) -> List<TvShowObject>? {
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
}
protocol TvShowListRealmProtocol {
    func forTvShow(from listTvShowModel: List<TvShowObject>, to realm: Realm, with indexOfTvShowList: TvShowList)
    func forTvShow(from realm: Realm, with indexOfTvShowList: TvShowList) -> List<TvShowObject>?
}
class MoviesDetailsRealm: MoviesDetailsRealmProtocol {
    // MARK: Save Movie Details to Realm
    func forMovieDetails(from movieDetailObject: MovieDetailObject, to realm: Realm) {
        try! realm.write {
            realm.add(movieDetailObject, update: .modified)
        }
    }
    // MARK: Load Movie Details from Realm
    func forMovieDetails(from realm: Realm, for movieId: Int) -> Results<MovieDetailObject> {
        let movieDetail: Results<MovieDetailObject> = realm.objects(MovieDetailObject.self).filter("id == \(movieId)")
        return movieDetail
    }
}
protocol MoviesDetailsRealmProtocol {
    func forMovieDetails(from movieDetailObject: MovieDetailObject, to realm: Realm)
    func forMovieDetails(from realm: Realm, for movieId: Int) -> Results<MovieDetailObject>
}

class TvShowDetailsRealm: TvShowDetailsRealmProtocol {
    // MARK: Save Movie Details to Realm
    func forTvShowDetails(from tvShowDetail: TvShowDetailObject, to realm: Realm) {
        try! realm.write {
            realm.add(tvShowDetail, update: .modified)
        }
    }
    // MARK: Load Movie Details from Realm
    func forTvShowDetails(from realm: Realm, for tvShowId: Int) -> Results<TvShowDetailObject> {
        let tvShowDetail: Results<TvShowDetailObject> = realm.objects(TvShowDetailObject.self).filter("id == \(tvShowId)")
        return tvShowDetail
    }
}
protocol TvShowDetailsRealmProtocol {
    func forTvShowDetails(from tvShowDetail: TvShowDetailObject, to realm: Realm)
    func forTvShowDetails(from realm: Realm, for tvShowId: Int) -> Results<TvShowDetailObject>
}
class CreditsRealm: CreditsRealmProtocol {
    // MARK: Save Movie Cast to Realm
    func forCast(from movieCast: [MovieCastObject], to realm: Realm) {
        movieCast.forEach {cast in
            try! realm.write {
                realm.add(cast, update: .modified)
            }
        }
    }
    // MARK: Save Movie Credits to Realm
    func forCredits(from listCredits: (List<MovieCastObject>, List<MovieCrewObject>), to realm: Realm, with movieID: Int) {
        try! realm.write {
            realm.create(MovieCreditObject.self, value: ["id": movieID, "cast": listCredits.0, "crew": listCredits.1], update: .modified)
        }
    }
    // MARK: Load Movie Cast from Realm
    func forCast(from realm: Realm, for movieId: Int) -> Results<MovieCastObject> {
        let cast: Results<MovieCastObject> = realm.objects(MovieCastObject.self).filter("movieId == \(movieId)")
        return cast
    }
    // MARK: Load MovieCreditResponse from Realm
    func forCredits(from realm: Realm, for movieId: Int) -> Results<MovieCreditObject> {
        let credits: Results<MovieCreditObject> = realm.objects(MovieCreditObject.self).filter("id == \(movieId)")
        return credits
    }
}
protocol CreditsRealmProtocol {
    func forCast(from movieCast: [MovieCastObject], to realm: Realm)
    func forCredits(from listCredits: (List<MovieCastObject>, List<MovieCrewObject>), to realm: Realm, with movieID: Int)
    func forCast(from realm: Realm, for movieId: Int) -> Results<MovieCastObject>
    func forCredits(from realm: Realm, for movieId: Int) -> Results<MovieCreditObject>
}
class GenresRealm: GenresRealmProtocol {
    // MARK: Save Movie Genres to Realm
    func forGenres(from genresDTO: [GenresDTO], to realm: Realm) {
        genresDTO.forEach { genre in
            let genres = GenresObject()
            genres.id = genre.id
            genres.name = genre.name
            try! realm.write {
                realm.add(genres, update: .modified)
            }
        }
    }
    // MARK: Load Movie Genres from Realm
    func forGenres(from realm: Realm) -> GenresDictionary {
        let genres: Results<GenresObject> = realm.objects(GenresObject.self)
        return Mappers.toGenresDictionary(from: genres)
    }
}
protocol GenresRealmProtocol {
    func forGenres(from genresDTO: [GenresDTO], to realm: Realm)
    func forGenres(from realm: Realm) -> GenresDictionary
}


