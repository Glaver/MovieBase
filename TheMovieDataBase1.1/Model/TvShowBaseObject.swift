//
//  TvShowBaseObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class TvShowBaseObject: Object {
    @objc dynamic var id: Int = 0

    let airingToday = List<TvShowObject>()
    let onTheAir    = List<TvShowObject>()
    let popularTV   = List<TvShowObject>()
    let topRatedTV  = List<TvShowObject>()

    override static func primaryKey() -> String? {
        return "id"
    }
}
