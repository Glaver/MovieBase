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
    let iso6391: String
    let iso31661: String
    let key: String
    let name: String
    let site: String
    let size: ResolutionVideo       //Allowed Values: 360, 480, 720, 1080
    let type: TypeVideo    //Allowed Values: Trailer, Teaser, Clip, Featurette, Behind the Scenes, Bloopers
}

enum TypeVideo: String, Codable {
    case trailer = "Trailer"
    case teaser = "Teaser"
    case clip = "Clip"
    case featurette = "Featurette"
    case behindTheScenes = "Behind The Scenes"
    case bloopers = "Bloopers"
}

enum ResolutionVideo: Int, Codable {
    case nHD = 360
    case dvd = 480
    case hdReady = 720
    case fullHD = 1080
}
