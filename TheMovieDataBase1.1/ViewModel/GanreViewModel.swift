//
//  MovieResponse.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 22/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import Combine
import RealmSwift

final class GanreViewModel: ObservableObject {
    @Published var genresEndpoint = Endpoint.movieGenres
    @Published var genres = [GenresDTO](){
        didSet {
            if genres.count > 0 {
                SaveModelObject.forGenres(from: genres, to: realm)
            }
        }
    }
    
    var dictionaryGanresRealm: GenresDictionary { return FetchModelObject.forGenres(from: realm) }
    
    var dictionaryGanres: GenresDictionary { return Mappers.toGenresDictionary(from: genres) }
    
    
    init(genresEndpoint: Endpoint) {
        self.genresEndpoint = genresEndpoint
        $genresEndpoint
        
        .flatMap { (ganreEndpoint) -> AnyPublisher<[GenresDTO], Never> in
        FetchData.shared.fetchGenres(from: Endpoint.movieGenres)//indexOfMoviesList)
            }
        .assign(to: \.genres, on: self)
        .store(in: &self.cancellationSet)
    }
    
    var cancellationSet: Set<AnyCancellable> = []
    
    deinit {
        for cancell in cancellationSet {
            cancell.cancel()
        }
    }
}
