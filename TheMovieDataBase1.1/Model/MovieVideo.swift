//
//  MovieVideo.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

struct MovieVideo: Codable {
    let id: Int
    let results: [MovieVideoResult]
}

struct MovieVideoResult: Identifiable, Codable {
    let id: String
    let iso_639_1: String
    let iso_3166_1: String
    let key: String
    let name: String
    let site: String
    let size: Int       //Allowed Values: 360, 480, 720, 1080
    let type: String    //Allowed Values: Trailer, Teaser, Clip, Featurette, Behind the Scenes, Bloopers
}
