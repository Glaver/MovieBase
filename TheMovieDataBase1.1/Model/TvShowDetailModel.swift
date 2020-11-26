//
//  TvShowDetailModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//https://developers.themoviedb.org/3/tv/get-tv-details

import Foundation

struct TvShowDetailModel: Codable, DetailViewHeadImagesTitleProtocol, InfoDetailContentViewProtocol {
    let backdropPath: String?
    let createdBy: [CreatedBy]
    let episodeRunTime: [Int]
    let firstAirDate: Date
    let genres: [GenresDTO]
    let homepage: String?
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: Date?
//    let lastEpisodeToAir: [Episode]
    let name: String
//    let nextEpisodeToAir: Date?
    let networks: [Networks]
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Float
    let posterPath: String?
    let productionCompanies: [ProductionCompaniesModel]
    let seasons: [Seasons]
    let status: String
    let tagline: String?
    let type: String
    let voteAverage: Float
    let voteCount: Int
    var title: String { name }
    var originalTitle: String { name }
    var posterFilemanagerName: String { "\(id)poster" }
    var backdropFilemanagerName: String { "\(id)backDrop" }
    var releaseDate: Date { lastAirDate ?? Date() }
    var runtime: Int? { nil }
}

struct CreatedBy: Codable {
    let id: Int
    let creditId: String
    let name: String
    let gender: Int
    let profilePath: String?
}

struct Episode: Codable {
    //let airDate: Date
    let episodeNumber: Int
    let id: Int
    let name: String
    let overview: String
    let productionCode: String
    let seasonNumber: Int
    let stillPath: String?
    let voteAverage: Float
    let voteCount: Int
}

struct Networks: Codable {
    let name: String
    let id: Int
    let logoPath: String
    let originCountry: String
}

struct Seasons: Codable {
    let airDate: Date?
    let episodeCount: Int
    let id: Int
    let name: String
    let overview: String
    let posterPath: String?
    let seasonNumber: Int
}

extension TvShowDetailModel {
    init() {
        backdropPath = nil
        createdBy = [CreatedBy(id: 0, creditId: "", name: "", gender: 0, profilePath: "")]
        episodeRunTime = [0]
        firstAirDate = Date()
        genres = [GenresDTO(id: 0, name: "")]
        homepage = ""
        id = 0
        inProduction = false
        languages = [""]
        lastAirDate = Date()
//        lastEpisodeToAir = [Episode(airDate: Date(),
//                                    episodeNumber: 0,
//                                    id: 0,
//                                    name: "",
//                                    overview: "",
//                                    productionCode: "",
//                                    seasonNumber: 0,
//                                    stillPath: "",
//                                    voteAverage: 0.0,
//                                    voteCount: 0)]
        name = ""
        //nextEpisodeToAir = Date()
        networks = [Networks(name: "", id: 0, logoPath: "", originCountry: "")]
        numberOfEpisodes = 0
        numberOfSeasons = 0
        originCountry = [""]
        originalLanguage = ""
        originalName = ""
        overview = "empty"
        popularity = 0
        posterPath = nil
        productionCompanies = [ProductionCompaniesModel(name: "", id: 0, logoPath: "", originCountry: "")]
        seasons = [Seasons(airDate: Date(),
                           episodeCount: 0,
                           id: 0,
                           name: "",
                           overview: "",
                           posterPath: "",
                           seasonNumber: 0)]
        status = ""
        tagline = ""
        type = ""
        voteAverage = 0
        voteCount = 0
    }
}
