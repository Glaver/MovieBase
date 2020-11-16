//
//  Errors.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 16/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

enum Errors: Error, LocalizedError, Identifiable {
    var id: String { localizedDescription }
    case urlError(URLError)
    case responseError((Int, String))
    case decodingError(DecodingError)
    case genericError
}
