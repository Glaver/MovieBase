//
//  GenresObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class GenresObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(id: Int, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
