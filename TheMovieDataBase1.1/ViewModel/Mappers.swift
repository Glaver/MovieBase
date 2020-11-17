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
    // MARK: Map ResultDTO to MovieModel
    static func toMovieModel(from movieDataModel: [ResultDTO]) -> [MovieModel] {
        var movies = [MovieModel]()
        movieDataModel.forEach { result in
            movies.append(MovieModel(popularity: result.popularity,
                                     id: result.id,
                                     title: result.title,
                                     backdropPosterPath: result.backdropPath,
                                     posterPath: result.posterPath,
                                     genres: result.genreIds,
                                     overview: result.overview,
                                     releaseDate: result.releaseDate,
                                     voteAverage: result.voteAverage))
        }
        return movies
    }
    // MARK: Map MovieModelObject to MovieModel
    static func toMovieModel(from movieModelObject: [MovieModelObject]) -> [MovieModel] {
            var movies = [MovieModel]()
            movieModelObject.forEach { result in
                movies.append(MovieModel(popularity: result.popularity,
                                         id: result.id,
                                         title: result.title,
                                         backdropPosterPath: result.backdropPosterPath,
                                         posterPath: result.posterPath,
                                         genres: Array(result.genres),
                                         overview: result.overview,
                                         releaseDate: result.releaseDate,
                                         voteAverage: result.voteAverage))
            }
            return movies
        }
    // MARK: Map MovieCast with movieID to MovieCastObject
    static func toMovieCastObject(from movieCast: [MovieCast], for movieId: Int) -> [MovieCastObject] {
        var casts = [MovieCastObject]()
        movieCast.forEach { cast in
            casts.append(MovieCastObject(id: cast.id, //movieId: movieId,
                                         key: (cast.id + movieId),
                                         character: cast.character,
                                         profilePath: cast.profilePath,
                                         name: cast.name))
        }
        return casts
    }
    // MARK: Map MovieCastObject with movieID to MovieCast
    static func toMovieCast(from movieCastObject: [MovieCastObject], for movieId: Int) -> [MovieCast] {
        var casts = [MovieCast]()
        movieCastObject.forEach { cast in
            casts.append(MovieCast(id: cast.id, character: cast.character, name: cast.name, profilePath: cast.profilePath))//, movieId: movieId
        }
        return casts
    }

    // MARK: Map MovieCredit with movieID to MovieCreditObject
    static func toMovieCreditLists(from movieCredit: MovieCreditResponse, for movieId: Int) -> (List<MovieCastObject>, List<MovieCrewObject>) {

        let castObject = List<MovieCastObject>()
        let crewObject = List<MovieCrewObject>()

        movieCredit.cast.forEach { cast in
            let newCast = MovieCastObject(id: cast.id,
                                          key: (cast.id + movieId),
                                          character: cast.character,
                                          profilePath: cast.profilePath,
                                          name: cast.name)
            castObject.append(newCast)
        }

        movieCredit.crew.forEach { crew in
            let newCrew = MovieCrewObject(id: crew.id,
                                          department: crew.department,
                                          job: crew.job,
                                          name: crew.name,
                                          key: (crew.id + movieId))
            crewObject.append(newCrew)
        }

        return (castObject, crewObject)
    }

    // MARK: Map MovieCreditObject to MovieCreditResponse
    static func toMovieCreditResponse(from movieCreditObject: MovieCreditObject) -> MovieCreditResponse {
        var movieCast = [MovieCast]()
        var movieCrew = [MovieCrew]()

        movieCreditObject.cast.forEach { cast in

            movieCast.append(MovieCast(id: cast.id,
                                       character: cast.character,
                                       name: cast.name,
                                       profilePath: cast.profilePath))
        }

        movieCreditObject.crew.forEach { crew in

            movieCrew.append(MovieCrew(id: crew.id,
                                       department: crew.department,
                                       job: crew.job,
                                       name: crew.name))
        }

        return MovieCreditResponse(cast: movieCast, crew: movieCrew)
    }

    // MARK: Map GenresDTO to GenresDictionary
    static func toGenresDictionary(from genresDataModel: [GenresDTO]) -> GenresDictionary {
        var tempDict = [Int: String]()
        genresDataModel.forEach { genre in
            let key = genre.id as Int
            let value = genre.name as String
            tempDict[key] = value
        }
        return GenresDictionary(genres: tempDict)
    }
    // MARK: Map Results<GenresObject> to GenresDictionary
    static func toGenresDictionary(from resultsGenresObject: Results<GenresObject>) -> GenresDictionary {
        var dictionaryOfGenres = [Int: String]()
        resultsGenresObject.forEach { genre in
            let key = genre.id as Int
            let value = genre.name as String
            dictionaryOfGenres[key] = value
        }
        return GenresDictionary(genres: dictionaryOfGenres)
    }
    // MARK: Map from MovieDetailModel to MovieDetailObject
    static func toMovieDetailObject(from movieDetailModel: MovieDetailModel) -> MovieDetailObject {
        let movieDetailObject = MovieDetailObject(adult: movieDetailModel.adult,
                                                  backdropPath: movieDetailModel.backdropPath,
                                                  budget: movieDetailModel.budget,
                                                  homepage: movieDetailModel.homepage,
                                                  id: movieDetailModel.id,
                                                  imdbId: movieDetailModel.imdbId,
                                                  originalLanguage: movieDetailModel.originalLanguage,
                                                  originalTitle: movieDetailModel.originalTitle,
                                                  overview: movieDetailModel.overview,
                                                  popularity: movieDetailModel.popularity,
                                                  posterPath: movieDetailModel.posterPath,
                                                  releaseDate: movieDetailModel.releaseDate,
                                                  revenue: movieDetailModel.revenue,
                                                  status: movieDetailModel.status,
                                                  tagline: movieDetailModel.tagline,
                                                  title: movieDetailModel.title,
                                                  video: movieDetailModel.video,
                                                  voteAverage: movieDetailModel.voteAverage,
                                                  voteCount: movieDetailModel.voteCount)

        movieDetailObject.runtime.value = movieDetailModel.runtime

        movieDetailModel.genres.forEach { genre in
            movieDetailObject.genres.append(GenresObject(id: genre.id, name: genre.name))
        }

        movieDetailModel.productionCompanies.forEach { companies in
            movieDetailObject.productionCompanies.append(ProductionCompaniesObject(name: companies.name, id: companies.id, logoPath: companies.logoPath, originCountry: companies.originCountry))
        }

        movieDetailModel.productionCountries.forEach { countries in
            movieDetailObject.productionCountries.append(ProductionCountriesObject(iso31661: countries.iso31661, name: countries.name))
        }

        movieDetailModel.spokenLanguages.forEach { languages in
            movieDetailObject.spokenLanguages.append(SpokenLanguagesObject(iso6391: languages.iso6391, name: languages.name))
        }
        return movieDetailObject
    }
    // MARK: Map from MovieDetailObject to MovieDetailModel
    static func toMovieDetailModel(from movieDetailObject: MovieDetailObject) -> MovieDetailModel {
        var genresDTO = [GenresDTO]()
        movieDetailObject.genres.forEach { genre in
            genresDTO.append(GenresDTO(id: genre.id, name: genre.name))}

        var prodCompanies = [ProductionCompaniesModel]()
        movieDetailObject.productionCompanies.forEach { companies in
            prodCompanies.append(ProductionCompaniesModel(name: companies.name, id: companies.id, logoPath: companies.logoPath, originCountry: companies.originCountry))
        }

        var prodCountries = [ProductionCountries]()
        movieDetailObject.productionCountries.forEach { countries in
            prodCountries.append(ProductionCountries(iso31661: countries.iso31661, name: countries.name))
        }

        var spokLanguages = [SpokenLanguages]()
        movieDetailObject.spokenLanguages.forEach { languages in
            spokLanguages.append(SpokenLanguages(iso6391: languages.iso6391, name: languages.name))
        }

        let movieDetailModel = MovieDetailModel(adult: movieDetailObject.adult,
                                                 backdropPath: movieDetailObject.backdropPath,
                                                 budget: movieDetailObject.budget,
                                                 genres: genresDTO,
                                                 homepage: movieDetailObject.homepage,
                                                 id: movieDetailObject.id,
                                                 imdbId: movieDetailObject.imdbId,
                                                 originalLanguage: movieDetailObject.originalLanguage,
                                                 originalTitle: movieDetailObject.originalTitle,
                                                 overview: movieDetailObject.overview,
                                                 popularity: movieDetailObject.popularity,
                                                 posterPath: movieDetailObject.posterPath,
                                                 productionCompanies: prodCompanies,
                                                 productionCountries: prodCountries,
                                                 releaseDate: movieDetailObject.releaseDate,
                                                 revenue: movieDetailObject.revenue,
                                                 runtime: movieDetailObject.runtime.value,
                                                 spokenLanguages: spokLanguages,
                                                 status: movieDetailObject.status,
                                                 tagline: movieDetailObject.tagline,
                                                 title: movieDetailObject.title,
                                                 video: movieDetailObject.video,
                                                 voteAverage: movieDetailObject.voteAverage,
                                                 voteCount: movieDetailObject.voteCount)
        return movieDetailModel
    }

    // MARK: Map from ResultDTO to List<MovieModelObject>
    static func toMovieModelObjectList(from movieDataModel: [ResultDTO]) -> List<MovieModelObject> {
        let listOfMovie = List<MovieModelObject>()
        movieDataModel.forEach { model in

            let newMovie = MovieModelObject(popularity: model.popularity,
                                            id: model.id,
                                            title: model.title,
                                            backdropPosterPath: model.backdropPath ?? "",
                                            posterPath: model.posterPath ?? "",
                                            overview: model.overview,
                                            releaseDate: model.releaseDate,
                                            voteAverage: model.voteAverage)

            model.genreIds.forEach { id in newMovie.genres.append(id) }

            listOfMovie.append(newMovie)
        }
        return listOfMovie
    }
    // MARK: Map from ResultTvModel to List<TvShowObject>
    static func toTvShowObjectList(from tvShowDataModel: [ResultTvModel]) -> List<TvShowObject> {
        let listOfTvShow = List<TvShowObject>()
        tvShowDataModel.forEach { show in

            let newShow = TvShowObject(posterPath: show.posterPath,
                                        popularity: show.popularity,
                                        id: show.id,
                                        backdropPath: show.backdropPath,
                                        voteAverage: show.voteAverage,
                                        overview: show.overview,
                                        firstAirDate: show.firstAirDate,
                                        originalLanguage: show.originalLanguage,
                                        voteCount: show.voteCount,
                                        name: show.name,
                                        originalName: show.originalName)

            show.genreIds.forEach { id in newShow.genreIds.append(id) }
            show.originCountry.forEach { country in newShow.originCountry.append(country) }

            listOfTvShow.append(newShow)
        }
        return listOfTvShow
    }
    // MARK: Map from List<TvShowObject> to ResultTvModel
    static func toResultTvModel(from listTvShowDataModel: List<TvShowObject>) -> [ResultTvModel] {
        var resultTv = [ResultTvModel]()
        listTvShowDataModel.forEach { show in
            let newShow = ResultTvModel(posterPath: show.posterPath,
                                        popularity: show.popularity,
                                        id: show.id,
                                        backdropPath: show.backdropPath,
                                        voteAverage: show.voteAverage,
                                        overview: show.overview,
                                        firstAirDate: show.firstAirDate,
                                        originCountry: Array(show.originCountry),
                                        genreIds: Array(show.genreIds),
                                        originalLanguage: show.originalLanguage,
                                        voteCount: show.voteCount,
                                        name: show.name,
                                        originalName: show.originalName)
            resultTv.append(newShow)
        }
        return resultTv
    }

    // MARK: Map from GenresDictionary to String
    static func convertorGenresToString(genresDict: GenresDictionary, genresOfMovie: [Int]) -> [String] {
        var stringGenres = [String]()
        for (id, genre) in genresDict.genres {
            for idMovie in genresOfMovie where id == idMovie {
                //if id == idMovie {
                    stringGenres.append(genre)
                //}
            }
        }
        return stringGenres
    }

    // MARK: Map GenresDTO to array string
    static func convertsToArrayString(from genres: [GenresDTO]) -> [String] {
        var outputArrayString = [String]()
        genres.forEach { genres in
            outputArrayString.append(genres.name)
        }
        return outputArrayString
    }
    // MARK: Map from Minutes to String
    static func convertsIntToHoursAndMin(timeInMin: Int?) -> String {
        guard let time = timeInMin else {
            return " "
        }
        let hours = time / 60
        let minutes = time % 60
        return "\(String(hours)) h \(String(minutes)) m "
    }
    // MARK: Map if originalTitle is same as title not print
    static func originalTitle(_ title: String, vs englishTitle: String) -> String {
        var tempString = ""
        if title != englishTitle {
            tempString = title
        }
        return tempString
    }

}
