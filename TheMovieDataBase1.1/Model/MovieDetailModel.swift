//
//  MovieDetailModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 9/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI

struct MovieDetailModel: Codable {
    let adult: Bool
    let backdropPath: String?
    //let belongsToCollection: [String?]
    let budget: Int
    let genres: [GenresDTO]
    let homepage: String?
    let id: Int
    let imdbId: String? // minLength: 9 maxLength: 9 pattern: ^tt[0-9]{7}
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Float
    let posterPath: String?
    let productionCompanies: [ProductionCompaniesModel]
    let productionCountries: [ProductionCountries]
    let releaseDate: Date //format: date
    let revenue: Int
    let runtime: Int?
    let spokenLanguages: [SpokenLanguages]
    let status: String //Allowed Values: Rumored, Planned, In Production, Post Production, Released, Canceled
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int

    var posterFilemanagerName: String {
        return "\(id)poster"
    }
    var backdropFilemanagerName: String {
        return "\(id)backDrop"
    }

    init() {
        self.adult = false
        self.backdropPath = nil
        //let belongsToCollection: [String?]
        self.budget = 0
        self.genres = [GenresDTO(id: 0, name: "")]
        self.homepage = nil
        self.id = 0
        self.imdbId = nil // minLength: 9 maxLength: 9 pattern: ^tt[0-9]{7}
        self.originalLanguage = ""
        self.originalTitle = ""
        self.overview = nil
        self.popularity = 0
        self.posterPath = nil
        self.productionCompanies = [ProductionCompaniesModel(name: "", id: 0, logoPath: "", originCountry: "")]
        self.productionCountries = [ProductionCountries(iso31661: "", name: "")]
        self.releaseDate = Date() //format: date
        self.revenue = 0
        self.runtime = nil
        self.spokenLanguages = [SpokenLanguages(iso6391: "", name: "")]
        self.status = "" //Allowed Values: Rumored, Planned, In Production, Post Production, Released, Canceled
        self.tagline = nil
        self.title = ""
        self.video = false
        self.voteAverage = 0
        self.voteCount = 0
    }

    init(adult: Bool,
         backdropPath: String?,
         budget: Int,
         genres: [GenresDTO],
         homepage: String?,
         id: Int,
         imdbId: String?,
         originalLanguage: String,
         originalTitle: String,
         overview: String?,
         popularity: Float,
         posterPath: String?,
         productionCompanies: [ProductionCompaniesModel],
         productionCountries: [ProductionCountries],
         releaseDate: Date,
         revenue: Int,
         runtime: Int?,
         spokenLanguages: [SpokenLanguages],
         status: String,
         tagline: String?,
         title: String,
         video: Bool,
         voteAverage: Float,
         voteCount: Int) {
        self.adult = adult
        self.backdropPath = backdropPath
        //let belongsToCollection: [String?]
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbId = imdbId // minLength: 9 maxLength: 9 pattern: ^tt[0-9]{7}
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate //format: date
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status //Allowed Values: Rumored, Planned, In Production, Post Production, Released, Canceled
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

struct ProductionCompaniesModel: Codable {
    let name: String
    let id: Int
    let logoPath: String?
    let originCountry: String
}

struct ProductionCountries: Codable {
    let iso31661: String
    let name: String
}

struct SpokenLanguages: Codable {
    let iso6391: String
    let name: String
}
