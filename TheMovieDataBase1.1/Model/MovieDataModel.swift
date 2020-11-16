//
//  MovieDataModelDTO.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 15/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

public struct MovieDataDTO: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [ResultDTO]
}

public struct ResultDTO: Codable {
    let popularity: Float
    let voteCount: Int
    let video: Bool
    let posterPath: String?
    let id: Int
    let adult: Bool
    let backdropPath: String?
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let title: String
    let voteAverage: Float
    let overview: String
    let releaseDate: Date
}
