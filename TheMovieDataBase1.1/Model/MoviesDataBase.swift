//  DataModel.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 12/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import RealmSwift

class MoviesDataBase: Object {
    @objc dynamic var id: Int = 0
    let nowPlying = List<MovieModelObject>()
    let popular   = List<MovieModelObject>()
    let upcoming  = List<MovieModelObject>()
    let topRated  = List<MovieModelObject>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
