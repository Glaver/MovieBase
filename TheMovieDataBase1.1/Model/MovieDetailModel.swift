//
//  MovieDetailModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 9/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI

protocol DetailViewHeadImagesTitleProtocol {
    var backdropPath: String? { get }
    var backdropFilemanagerName: String { get }
    var posterPath: String? { get }
    var posterFilemanagerName: String { get }
    var tagline: String? { get }
    var title: String { get }
    var originalTitle: String { get }
}

protocol InfoDetailContentViewProtocol {
    var releaseDate: Date { get }
    var voteAverage: Float { get }
    var runtime: Int? { get }
    var homepage: String? { get }
}

struct MovieDetailModel: Codable, DetailViewHeadImagesTitleProtocol, InfoDetailContentViewProtocol {
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
    var posterFilemanagerName: String { "\(id)poster" }
    var backdropFilemanagerName: String { "\(id)backDrop" }
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

extension MovieDetailModel {
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
}
