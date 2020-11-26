//
//  MappersForView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 24/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

protocol MappersForViewProtocol {
    func convertorGenresToString(genresDict: GenresDictionaryProtocol, genresOfMovie: [Int]) -> [String]
    func convertsToArrayString(from genres: [GenresProtocol]) -> [String]
    func convertsIntToHoursAndMin(timeInMin: Int?) -> String
    func originalTitle(_ title: String, vs englishTitle: String) -> String
}
class MappersForView: MappersForViewProtocol {
    // MARK: Map from GenresDictionary to String
    func convertorGenresToString(genresDict: GenresDictionaryProtocol, genresOfMovie: [Int]) -> [String] {
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
    func convertsToArrayString(from genres: [GenresProtocol]) -> [String] {
        var outputArrayString = [String]()
        genres.forEach { genres in
            outputArrayString.append(genres.name)
        }
        return outputArrayString
    }
    // MARK: Map from Minutes to String
    func convertsIntToHoursAndMin(timeInMin: Int?) -> String {
        guard let time = timeInMin else {
            return " "
        }
        let hours = time / 60
        let minutes = time % 60
        return "\(String(hours)) h \(String(minutes)) m "
    }
    // MARK: Map if originalTitle is same as title not print
    func originalTitle(_ title: String, vs englishTitle: String) -> String {
        var tempString = ""
        if title != englishTitle {
            tempString = title
        }
        return tempString
    }
}
