//
//  TVshowListView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 29/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI

struct TvShowListView: View {
    @ObservedObject var tvShowViewModel = TvShowViewModel(indexOfTvShowList: TvShowList.airingToday, filteringMoviesIndex: FilterMovies.releaseDate)
    @ObservedObject var genresModel = GenreViewModel(genresEndpoint: Endpoint.tvGenres)
    @State var showFilters = false

    var body: some View {
            NavigationView {
                VStack {
                    Picker("", selection: $tvShowViewModel.indexOfTvShowList) {
                        Text(LocalizedStringKey("Airing today")).tag(TvShowList.airingToday)
                        Text(LocalizedStringKey("On The Air")).tag(TvShowList.onTheAir)
                        Text("Popular").tag(TvShowList.popularTV)
                        Text("Top Rated").tag(TvShowList.topRatedTV)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    ZStack(alignment: .topTrailing, content: {
                        ScrollViewMoviesShow(arrayDataFromAPI: tvShowViewModel.tvShowFromRealm, genresDictionary: genresModel.dictionaryGenresRealm)
                        if self.showFilters {
                            VStack(alignment: .center, spacing: 40) {
                                Picker("", selection: $tvShowViewModel.filteringMoviesIndex) {
                                    Text(LocalizedStringKey("Date")).tag(FilterMovies.releaseDate)
                                        .font(.system(size: 25))
                                        .foregroundColor(.blue)
                                    Text(LocalizedStringKey("Name")).tag(FilterMovies.title)
                                        .font(.system(size: 25))
                                        .foregroundColor(.blue)
                                    Text(LocalizedStringKey("Rating")).tag(FilterMovies.rating)
                                        .font(.system(size: 25))
                                        .foregroundColor(.blue)
                                    Text(LocalizedStringKey("Popularity")).tag(FilterMovies.popularity).font(.system(size: 25))
                                        .foregroundColor(.blue)
                                        }
                            }
                            .frame(width: 130, height: 130)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                        }

                    })
                }.alert(item: self.$tvShowViewModel.tvShowError) { error in
                    Alert(title: Text("Network error"),
                          message: Text(error.localizedDescription),
                          dismissButton: .default(Text("OK")))
                    }
                .alert(item: self.$genresModel.errorGenres) { error in
                    Alert(title: Text("Network error"),
                          message: Text(error.localizedDescription),
                          dismissButton: .default(Text("OK")))
                    }
                .navigationBarTitle(LocalizedStringKey("TV Show"), displayMode: .inline)
                .navigationBarItems(leading:
                                        HStack {
                                            Button(action: {
                                                FileManager.clearAllFile()
                                                //delete all files from file manager and realm database file
                                                //print("FileManager clear")
                                            }) {
                                                Image(systemName: "trash")
                                                    .resizable()
                                                    .frame(width: 23, height: 23)
                                                    .padding()
                                            }
                                 }, trailing:
                                        HStack {
                                            Button(action: {
                                                withAnimation(.spring()) {
                                                    self.showFilters.toggle()
                                                }
                                            }) {
                                                Image(systemName: "slider.horizontal.3")
                                                    .resizable()
                                                    .frame(width: 23, height: 23)
                                                    .padding()
                                                }
                                    })
            }
    }
}

struct ScrollViewMoviesShow: View {
    var arrayDataFromAPI: [MovieShowViewProtocol]
    var genresDictionary: GenresDictionaryProtocol

    var body: some View {
        VStack {
            List(self.arrayDataFromAPI, id: \.id) { show in
                NavigationLink(destination: TvShowDetailView(tvShow: show as! ResultTvModel)) {
                    SectionView(section: show, inputURLforImage: ImageAPI.Size.medium.path(poster: (show.posterPath ?? "")), genresDictionary: self.genresDictionary)
                }
            }
        }
    }
}
