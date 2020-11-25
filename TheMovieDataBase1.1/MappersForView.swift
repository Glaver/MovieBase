//
//  MappersForView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 24/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

class MappersForView {
    // MARK: Map from GenresDictionary to String
    static func convertorGenresToString(genresDict: GenresDictionaryProtocol, genresOfMovie: [Int]) -> [String] {
        var stringGenres = [String]()
        for (id, genre) in genresDict.genres {
            for idMovie in genresOfMovie where id == idMovie {
                //if id == idMovie {
                    stringGenres.append(genre)
                //}
            }
        }
        return stringGenres
    }

    // MARK: Map GenresDTO to array string
    static func convertsToArrayString(from genres: [GenresProtocol]) -> [String] {
        var outputArrayString = [String]()
        genres.forEach { genres in
            outputArrayString.append(genres.name)
        }
        return outputArrayString
    }
    // MARK: Map from Minutes to String
    static func convertsIntToHoursAndMin(timeInMin: Int?) -> String {
        guard let time = timeInMin else {
            return " "
        }
        let hours = time / 60
        let minutes = time % 60
        return "\(String(hours)) h \(String(minutes)) m "
    }
    // MARK: Map if originalTitle is same as title not print
    static func originalTitle(_ title: String, vs englishTitle: String) -> String {
        var tempString = ""
        if title != englishTitle {
            tempString = title
        }
        return tempString
    }
}
