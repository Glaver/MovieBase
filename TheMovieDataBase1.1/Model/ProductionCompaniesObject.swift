//
//  ProductionCompaniesObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class ProductionCompaniesObject: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String?
    @objc dynamic var originCountry: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(name: String, id: Int, logoPath: String?, originCountry: String) {
        self.init()
        self.name = name
        self.id = id
        self.logoPath = logoPath
        self.originCountry = originCountry
    }
}
