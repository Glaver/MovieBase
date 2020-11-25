//
//  Mappers.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 26/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

protocol MovieMappersProtocol {
    func toMovieModel(from movieModelObject: [MovieModelObject]) -> [MovieModel]
    func toMovieModelObjectList(from movieDataModel: [MovieModel]) -> List<MovieModelObject>
}
class MovieMappers: MovieMappersProtocol {
    // MARK: Map MovieModelObject to MovieModel
    func toMovieModel(from movieModelObject: [MovieModelObject]) -> [MovieModel] {
        var movies = [MovieModel]()
        movieModelObject.forEach { result in
            movies.append(MovieModel(popularity: 0,
                                     id: result.id,
                                     title: result.title,
                                     backdropPath: result.backdropPosterPath,
                                     posterPath: result.posterPath,
                                     overview: result.overview,
                                     releaseDate: result.releaseDate,
                                     voteAverage: result.voteAverage,
                                     voteCount: 0,
                                     video: false,
                                     adult: false,
                                     originalLanguage: "",
                                     originalTitle: "",
                                     genreIds: Array(result.genres)))
        }
        return movies
    }
    // MARK: Map from ResultDTO to List<MovieModelObject>
    func toMovieModelObjectList(from movieDataModel: [MovieModel]) -> List<MovieModelObject> {
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
}

protocol MovieDetailsMappersProtocol {
    func toMovieDetailObject(from movieDetailModel: MovieDetailModel) -> MovieDetailObject
    func toMovieDetailModel(from movieDetailObject: MovieDetailObject) -> MovieDetailModel
}
class MovieDetailsMappers: MovieDetailsMappersProtocol {
    // MARK: Map from MovieDetailModel to MovieDetailObject
    func toMovieDetailObject(from movieDetailModel: MovieDetailModel) -> MovieDetailObject {
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
    func toMovieDetailModel(from movieDetailObject: MovieDetailObject) -> MovieDetailModel {
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
}

protocol TvShowMappersProtocol {
    func toTvShowObjectList(from tvShowDataModel: [ResultTvModel]) -> List<TvShowObject>
    func toResultTvModel(from listTvShowDataModel: List<TvShowObject>) -> [ResultTvModel]
}
class TvShowMappers: TvShowMappersProtocol {
    // MARK: Map from ResultTvModel to List<TvShowObject>
    func toTvShowObjectList(from tvShowDataModel: [ResultTvModel]) -> List<TvShowObject> {
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
    func toResultTvModel(from listTvShowDataModel: List<TvShowObject>) -> [ResultTvModel] {
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
}
protocol TvShowDetailsMappersProtocol {
    func toTvShowDetailObject(from tvShowDetailModel: TvShowDetailModel) -> TvShowDetailObject
    func toTvShowDetail(from tvShowDetailObject: TvShowDetailObject) -> TvShowDetailModel
}
class TvShowDetailsMappers: TvShowDetailsMappersProtocol {
    // MARK: Map from TvShowDetailModel to TvShowDetailObject
    func toTvShowDetailObject(from tvShowDetailModel: TvShowDetailModel) -> TvShowDetailObject {
        let showDetailObject = TvShowDetailObject(backdropPath: tvShowDetailModel.backdropPath,
                                                  firstAirDate: tvShowDetailModel.firstAirDate,
                                                  homepage: tvShowDetailModel.homepage ?? "",
                                                  id: tvShowDetailModel.id,
                                                  inProduction: tvShowDetailModel.inProduction,
                                                  lastAirDate: tvShowDetailModel.lastAirDate,
                                                  name: tvShowDetailModel.name,
                                                  numberOfEpisodes: tvShowDetailModel.numberOfEpisodes,
                                                  numberOfSeasons: tvShowDetailModel.numberOfSeasons,
                                                  originalLanguage: tvShowDetailModel.originalLanguage,
                                                  originalName: tvShowDetailModel.originalLanguage,
                                                  overview: tvShowDetailModel.overview,
                                                  popularity: tvShowDetailModel.popularity,
                                                  posterPath: tvShowDetailModel.posterPath,
                                                  status: tvShowDetailModel.status,
                                                  tagline: tvShowDetailModel.tagline ?? "",
                                                  type: tvShowDetailModel.type,
                                                  voteAverage: tvShowDetailModel.voteAverage,
                                                  voteCount: tvShowDetailModel.voteCount)
        tvShowDetailModel.createdBy.forEach { created in
            showDetailObject.createdBy.append(CreatedByObject(id: created.id,
                                                              creditId: created.creditId,
                                                              name: created.name,
                                                              gender: created.gender,
                                                              profilePath: created.profilePath ?? ""))
        }
        tvShowDetailModel.episodeRunTime.forEach { time in showDetailObject.episodeRunTime.append(time) }
        tvShowDetailModel.genres.forEach { genre in showDetailObject.genres.append(GenresObject(id: genre.id, name: genre.name))
        }
        tvShowDetailModel.languages.forEach { languages in showDetailObject.languages.append(languages) }
        tvShowDetailModel.networks.forEach { network in showDetailObject.networks.append(NetworksObject(name: network.name,
                                                                                                        id: network.id,
                                                                                                        logoPath: network.logoPath,
                                                                                                        originCountry: network.originCountry))
        }
        tvShowDetailModel.originCountry.forEach { country in showDetailObject.originCountry.append(country) }
        tvShowDetailModel.productionCompanies.forEach { companies in showDetailObject.productionCompanies.append(ProductionCompaniesObject(
                                                                                                                    name: companies.name,
                                                                                                                    id: companies.id,
                                                                                                                    logoPath: companies.logoPath,
                                                                                                                    originCountry: companies.originCountry))
        }
        tvShowDetailModel.seasons.forEach { seasons in showDetailObject.seasons.append(SeasonsObject(airDate: seasons.airDate ?? Date(),
                                                                                                     episodeCount: seasons.episodeCount,
                                                                                                     id: seasons.id,
                                                                                                     name: seasons.name,
                                                                                                     overview: seasons.overview,
                                                                                                     posterPath: seasons.posterPath,
                                                                                                     seasonNumber: seasons.seasonNumber))
        }
        return showDetailObject
    }
    // MARK: Map from TvShowDetailModel to TvShowDetailObject
    func toTvShowDetail(from tvShowDetailObject: TvShowDetailObject) -> TvShowDetailModel {
        var createdBy = [CreatedBy]()
        tvShowDetailObject.createdBy.forEach { created in
            createdBy.append(CreatedBy(id: created.id,
                                       creditId: created.creditId,
                                       name: created.name,
                                       gender: created.gender,
                                       profilePath: created.profilePath))
        }
        var episodeRunTime = [Int]()
        tvShowDetailObject.episodeRunTime.forEach { time in episodeRunTime.append(time)}
        var genresDTO = [GenresDTO]()
        tvShowDetailObject.genres.forEach { genre in
            genresDTO.append(GenresDTO(id: genre.id, name: genre.name))}
        var languages = [String]()
        tvShowDetailObject.languages.forEach { language in languages.append(language)}
        var networks = [Networks]()
        tvShowDetailObject.networks.forEach { network in
            networks.append(Networks(name: network.name,
                                     id: network.id,
                                     logoPath: network.logoPath,
                                     originCountry: network.originCountry))
        }
        var originCountry = [String]()
        tvShowDetailObject.originCountry.forEach { country in originCountry.append(country) }
        var productionCompanies = [ProductionCompaniesModel]()
        tvShowDetailObject.productionCompanies.forEach { companies in
            productionCompanies.append(ProductionCompaniesModel(name: companies.name,
                                                                id: companies.id,
                                                                logoPath: companies.logoPath,
                                                                originCountry: companies.originCountry))
        }
        var seasons = [Seasons]()
        tvShowDetailObject.seasons.forEach { season in
            seasons.append(Seasons(airDate: season.airDate,
                                   episodeCount: season.episodeCount,
                                   id: season.id,
                                   name: season.name,
                                   overview: season.overview,
                                   posterPath: season.posterPath,
                                   seasonNumber: season.seasonNumber))
        }
        let tvShowDetailModelOutput = TvShowDetailModel(backdropPath: tvShowDetailObject.backdropPath,
                                                        createdBy: createdBy,
                                                        episodeRunTime: episodeRunTime,
                                                        firstAirDate: tvShowDetailObject.firstAirDate,
                                                        genres: genresDTO,
                                                        homepage: tvShowDetailObject.homepage,
                                                        id: tvShowDetailObject.id,
                                                        inProduction: tvShowDetailObject.inProduction,
                                                        languages: languages,
                                                        lastAirDate: tvShowDetailObject.lastAirDate,
                                                        name: tvShowDetailObject.name,
                                                        networks: networks,
                                                        numberOfEpisodes: tvShowDetailObject.numberOfEpisodes,
                                                        numberOfSeasons: tvShowDetailObject.numberOfSeasons,
                                                        originCountry: originCountry,
                                                        originalLanguage: tvShowDetailObject.originalLanguage,
                                                        originalName: tvShowDetailObject.originalName,
                                                        overview: tvShowDetailObject.overview,
                                                        popularity: tvShowDetailObject.popularity,
                                                        posterPath: tvShowDetailObject.posterPath,
                                                        productionCompanies: productionCompanies,
                                                        seasons: seasons,
                                                        status: tvShowDetailObject.status,
                                                        tagline: tvShowDetailObject.tagline,
                                                        type: tvShowDetailObject.type,
                                                        voteAverage: tvShowDetailObject.voteAverage,
                                                        voteCount: tvShowDetailObject.voteCount)
        return tvShowDetailModelOutput
    }
}
protocol CreditsMappersProtocol {
    func toMovieCreditLists(from movieCredit: MovieCreditResponse, for movieId: Int) -> MovieCreditObject
    func toMovieCreditResponse(from movieCreditObject: MovieCreditObject) -> MovieCreditResponse
}
class CreditsMappers: CreditsMappersProtocol {
    // MARK: Map MovieCredit with movieID to MovieCreditObject
    func toMovieCreditLists(from movieCredit: MovieCreditResponse, for movieId: Int) -> MovieCreditObject {
        let creditsObject = MovieCreditObject(id: movieId)
        movieCredit.cast.forEach { cast in
            creditsObject.cast.append(MovieCastObject(id: cast.id,
                                          creditId: cast.creditId,
                                          character: cast.character,
                                          profilePath: cast.profilePath,
                                          name: cast.name))
        }

        movieCredit.crew.forEach { crew in
            creditsObject.crew.append(MovieCrewObject(id: crew.id,
                                          department: crew.department,
                                          job: crew.job,
                                          name: crew.name,
                                          creditId: crew.creditId))
        }
        return creditsObject
    }

    // MARK: Map MovieCreditObject to MovieCreditResponse
    func toMovieCreditResponse(from movieCreditObject: MovieCreditObject) -> MovieCreditResponse {
        var movieCast = [MovieCast]()
        var movieCrew = [MovieCrew]()

        movieCreditObject.cast.forEach { cast in

            movieCast.append(MovieCast(id: cast.id,
                                       character: cast.character,
                                       name: cast.name,
                                       profilePath: cast.profilePath,
                                       creditId: cast.creditId))
        }

        movieCreditObject.crew.forEach { crew in

            movieCrew.append(MovieCrew(id: crew.id,
                                       department: crew.department,
                                       job: crew.job,
                                       name: crew.name,
                                       creditId: crew.creditId))
        }

        return MovieCreditResponse(id: movieCreditObject.id, cast: movieCast, crew: movieCrew)
    }
}
protocol GenresMappersProtocol {
    func toGenresDictionary(from resultsGenresObject: Results<GenresObject>) -> GenresDictionary
    func toGenresDictionary(from genresDataModel: [GenresDTO]) -> GenresDictionary
}
class GenresMappers: GenresMappersProtocol {
    // MARK: Map GenresDTO to GenresDictionary
    func toGenresDictionary(from genresDataModel: [GenresDTO]) -> GenresDictionary {
        var tempDict = [Int: String]()
        genresDataModel.forEach { genre in
            let key = genre.id as Int
            let value = genre.name as String
            tempDict[key] = value
        }
        return GenresDictionary(genres: tempDict)
    }
    // MARK: Map Results<GenresObject> to GenresDictionary
    func toGenresDictionary(from resultsGenresObject: Results<GenresObject>) -> GenresDictionary {
        var dictionaryOfGenres = [Int: String]()
        Array(resultsGenresObject).forEach { genre in
            let key = genre.id as Int
            let value = genre.name as String
            dictionaryOfGenres[key] = value
        }
        return GenresDictionary(genres: dictionaryOfGenres)
    }
}
