//
//  MovieModelObject.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 25/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import RealmSwift

class MovieModelObject: Object {
    @objc dynamic var popularity: Float = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var backdropPosterPath: String? = ""
    @objc dynamic var posterPath: String? = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: Date = Date()
    @objc dynamic var voteAverage: Float = 0

    let genres = List<Int>()

    override static func primaryKey() -> String? {
            return "id"
        }

    convenience init(popularity: Float, id: Int, title: String, backdropPosterPath: String?, posterPath: String?, overview: String, releaseDate: Date, voteAverage: Float) {
        self.init()
        self.popularity = popularity
        self.id = id
        self.title = title
        self.backdropPosterPath = backdropPosterPath
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
    }
}
