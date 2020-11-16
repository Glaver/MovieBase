//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 20/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

struct MovieModel: MovieAndShowProperty, Hashable {
    let popularity: Float
    let id: Int
    let title: String
    let backdropPosterPath: String?
    let posterPath: String?
    let genres: [Int]
    let overview: String
    let releaseDate: Date
    let voteAverage: Float

    var posterFileManagerName: String {
        return "\(id)poster"
    }
    var backdropFileManagerName: String {
        return "\(id)backDrop"
    }
}

protocol MovieAndShowProperty {
    var popularity: Float { get }
    var id: Int { get }
    var title: String { get }
    var backdropPosterPath: String? { get }
    var posterPath: String? { get }
    var genres: [Int] { get }
    var overview: String { get }
    var releaseDate: Date { get }
    var voteAverage: Float { get }
    var posterFileManagerName: String { get }
    var backdropFileManagerName: String { get }
}
