//
//  Mappers.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 26/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

struct Mappers {
    static func toMovieModel(from movieDataModel: [ResultDTO]) -> [MovieModel] {
        var movies = [MovieModel]()
        movieDataModel.forEach{ result in
            movies.append(MovieModel(id: result.id,
                                     title: result.title,
                                     backdropPosterPath: result.backdropPath,
                                     posterPath: result.posterPath,
                                     genres: result.genreIds,
                                     overview: result.overview,
                                     releaseDate: DateFormatter.dateConvertor(result.releaseDate),
                                     rating: result.voteAverage))
        }
        return movies
    }
        
    static func toMovieModel(from movieModelObject: [MovieModelObject]) -> [MovieModel] {
            var movies = [MovieModel]()
            movieModelObject.forEach { result in
                movies.append(MovieModel(id: result.id,
                                         title: result.title,
                                         backdropPosterPath: result.backdropPosterPath,
                                         posterPath: result.posterPath,
                                         genres: Array(result.genres),
                                         overview: result.overview,
                                         releaseDate: result.releaseDate,
                                         rating: result.rating))
            }
            return movies
        }
    
    static func toMovieCastObject(from movieCast: [MovieCast], for movieId: Int) -> [MovieCastObject] {
        var casts = [MovieCastObject]()
        movieCast.forEach{ cast in
            casts.append(MovieCastObject(id: cast.id, movieId: movieId, key: (cast.id + movieId), character: cast.character, profilePath: cast.profilePath, name: cast.name))
        }
        return casts
    }
    
    static func toMovieCast(from movieCastObject: [MovieCastObject], for movieId: Int) -> [MovieCast] {
        var casts = [MovieCast]()
        movieCastObject.forEach{ cast in
            casts.append(MovieCast(id: cast.id, character: cast.character, name: cast.name, profilePath: cast.profilePath))//, movieId: movieId
        }
        return casts
    }

    
    static func toGenresDictionary(from genresDataModel: [GenresDTO]) -> GenresDictionary {
        var tempDict = [Int : String]()
        genresDataModel.forEach{ ganre in
            let key = ganre.id as Int
            let value = ganre.name as String
            tempDict[key] = value
        }
        return GenresDictionary(genres: tempDict)
    }
    
    static func toGenresDictionary(from resultsGenresObject: Results<GenresObject>) -> GenresDictionary {
        var dictionaryOfGenres = [Int : String]()
        resultsGenresObject.forEach{ ganre in
            let key = ganre.id as Int
            let value = ganre.name as String
            dictionaryOfGenres[key] = value
        }
        return GenresDictionary(genres: dictionaryOfGenres)
    }
    
    static func toMovieModelObjectList(from movieDataModel: [ResultDTO]) -> List<MovieModelObject> {
        let listOfMovie = List<MovieModelObject>()
        movieDataModel.forEach{ model in
            
            let newMovie = MovieModelObject(id: model.id,
                                            title: model.title,
                                            backdropPosterPath: model.backdropPath ?? "",
                                            posterPath: model.posterPath ?? "",
                                            overview: model.overview,
                                            releaseDate: DateFormatter.dateConvertor(model.releaseDate),
                                            rating: model.voteAverage)
            
            model.genreIds.forEach{ id in newMovie.genres.append(id) }
            
            listOfMovie.append(newMovie)
        }
        return listOfMovie
    }
    
    static func convertorGenresToString(ganresDict: GenresDictionary, genresOfMovie: [Int]) -> String {
        var stringGenres = ""
        for (id, genre) in ganresDict.genres{
            for idMovie in genresOfMovie{
                if id == idMovie {
                    stringGenres += genre + ", "
                }
            }
        }
        return String(stringGenres.dropLast(2))
    }
    
    
}
