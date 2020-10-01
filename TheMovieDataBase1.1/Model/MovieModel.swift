//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 20/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

struct MovieModel {
    let id: Int
    let title: String
    let backdropPosterPath: String?
    let posterPath: String?
    let genres: [Int]
    let overview: String
    let releaseDate: Date
    let rating: Float
    
    var posterFilemanagerName: String {
        return "\(id)poster"
    }
    var backdropFilemanagerName: String {
        return "\(id)backDrop"
    }
}
