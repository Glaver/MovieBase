//
//  Movie.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//https://developers.themoviedb.org/3/credits/get-credit-details

import Foundation

struct MovieCreditResponse: Codable {
    let id: Int
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Identifiable, Codable {
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
    let creditId: String
}

struct MovieCrew: Identifiable, Codable {
    let id: Int
    let department: String
    let job: String
    let name: String
    let creditId: String
}

extension MovieCreditResponse {
    init() {
        self.id = 0
        self.cast = [MovieCast(id: 0, character: "", name: "", profilePath: nil, creditId: "")]
        self.crew = [MovieCrew(id: 0, department: "", job: "", name: "", creditId: "")]
    }
}
