//
//  Movie.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

struct MovieCreditResponse: Codable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Identifiable, Codable {
    let id: Int
    let character: String
    let name: String
    let profilePath: String?
}

struct MovieCrew: Identifiable, Codable {
    let id: Int
    let department: String
    let job: String
    let name: String
}
