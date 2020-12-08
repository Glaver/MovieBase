//
//  MovieViewModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 20/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//API
//https://developers.themoviedb.org/3/movies/get-latest-movie

import Foundation

public struct MovieDataDTO: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MovieModel]
}

struct MovieModel: Hashable, Codable, MovieShowViewProtocol, FilterTvShowAndMovies {
    let popularity: Float
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let releaseDate: Date
    let voteAverage: Float
    let voteCount: Int
    let video: Bool
    let adult: Bool
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
//    var posterFileManagerName: String {
//        return "\(id)poster"
//    }
//    var backdropFileManagerName: String {
//        return "\(id)backDrop"
//    }
}

protocol MovieShowViewProtocol {
    var popularity: Float { get }
    var id: Int { get }
    var title: String { get }
    var backdropPath: String? { get }
    var posterPath: String? { get }
    var genreIds: [Int] { get }
    var overview: String { get }
    var releaseDate: Date { get }
    var voteAverage: Float { get }
//    var posterFileManagerName: String { get }
//    var backdropFileManagerName: String { get }
}
