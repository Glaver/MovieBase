//
//  MovieCreditObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class MovieCreditObject: Object {
    @objc dynamic var id: Int = 0
    let cast = List<MovieCastObject>()
    let crew = List<MovieCrewObject>()

    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: Int) {
        self.init()
        self.id = id
    }
}

class MovieCastObject: Object {
    @objc dynamic var id: Int  = 0
    @objc dynamic var creditId: String  = ""
    @objc dynamic var character: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var profilePath: String? = ""

    override static func primaryKey() -> String? {
        return "creditId"
    }

    convenience init(id: Int, creditId: String, character: String, profilePath: String?, name: String) {
        self.init()
        self.id = id
        self.creditId = creditId
        self.character = character
        self.profilePath = profilePath
        self.name = name
    }
}

class MovieCrewObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var department: String = ""
    @objc dynamic var job: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var creditId: String  = ""

    override static func primaryKey() -> String? {
        return "creditId"
    }

    convenience init(id: Int, department: String, job: String, name: String, creditId: String) {
        self.init()
        self.id = id
        self.department = department
        self.job = job
        self.name = name
        self.creditId = creditId
    }
}
