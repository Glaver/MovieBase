//
//  GanresModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 20/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

public struct GenreDTO: Codable {
    let genres: [GenresDTO]
}


struct GenresDTO: Codable{
    let id: Int
    let name: String
}
