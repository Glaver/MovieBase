//
//  GanresModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 20/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

protocol GenresProtocol {
    var id: Int { get }
    var name: String { get }
}

protocol GenresDictionaryProtocol {
    var genres: [Int: String] { get }
}

public struct GenreDTO: Codable {
    let genres: [GenresDTO]
}

struct GenresDTO: Codable, GenresProtocol {
    let id: Int
    let name: String
}

struct GenresDictionary: GenresDictionaryProtocol {
    let genres: [Int: String]
}
