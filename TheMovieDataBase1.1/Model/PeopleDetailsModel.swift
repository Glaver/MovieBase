//
//  PeopleDetailsModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 30/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//https://developers.themoviedb.org/3/people/get-person-details

import Foundation

struct PeopleDetailsModel: Codable, InfoDetailContentViewProtocol {
    enum Gender: Int, Codable {
        case other = 0
        case male = 1
        case female = 2
    }
    var releaseDate: Date { return birthday }
    var voteAverage: Float { return popularity }
    var runtime: Int? { return nil }

    let birthday: Date
    let knownForDepartment: String
    let deathday: String?
    let id: Int
    let name: String
    let alsoKnownAs: [String]
    let gender: Gender
    let biography: String
    let popularity: Float
    let placeOfBirth: String?
    let profilePath: String?
    let adult: Bool
    let imdbId: String
    let homepage: String?
}

extension PeopleDetailsModel {
    init() {
        self.birthday = Date()
        self.knownForDepartment = ""
        self.deathday = ""
        self.id = 0
        self.name = ""
        self.alsoKnownAs = [""]
        self.gender = Gender.init(rawValue: 0)!
        self.biography = ""
        self.popularity = 0
        self.placeOfBirth = ""
        self.profilePath = ""
        self.adult = false
        self.imdbId = ""
        self.homepage = ""
    }
}
