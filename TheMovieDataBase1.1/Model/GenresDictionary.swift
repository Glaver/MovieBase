//
//  GenresDictionary.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 20/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

struct GenresDictionary: GenresDictionaryProtocol {
    let genres: [Int: String]
}

protocol GenresDictionaryProtocol {
    var genres: [Int: String] { get }
}
