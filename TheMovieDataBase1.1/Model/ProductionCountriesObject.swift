//
//  ProductionCountriesObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class ProductionCountriesObject: Object {
    @objc dynamic var iso31661: String = ""
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "name"
    }

    convenience init(iso31661: String, name: String) {
        self.init()
        self.iso31661 = iso31661
        self.name = name
    }
}
