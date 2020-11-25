//
//  SpokenLanguagesObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class SpokenLanguagesObject: Object {
    @objc dynamic var iso6391: String = ""
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "name"
    }

    convenience init(iso6391: String, name: String) {
        self.init()
        self.iso6391 = iso6391
        self.name = name
    }
}
