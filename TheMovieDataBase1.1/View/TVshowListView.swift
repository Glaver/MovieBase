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
    @ObservedObject var tvShowViewModel = TvShowViewModel(indexOfTvShowList: TvShowList.popularTV,
                                                          filteringMoviesIndex: FilterContent.FilteredParameters.releaseDate,
                                                          realmService: TvShowListRealm(),
                                                          mappers: TvShowMappers(),
                                                          filter: FilterContent())
    @ObservedObject var genresModel = GenreViewModel(genresEndpoint: Endpoint.tvGenres,
                                                     realmService: GenresRealm(),
                                                     mappers: GenresMappers())
    @State var showFilters = false
    @State var isGrid = false
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $tvShowViewModel.indexOfTvShowList) {
                    Text(LocalizedStringKey("Airing today")).tag(TvShowList.airingToday)
                    Text(LocalizedStringKey("On The Air")).tag(TvShowList.onTheAir)
                    Text(LocalizedStringKey("Popular")).tag(TvShowList.popularTV)
                    Text(LocalizedStringKey("Top Rated")).tag(TvShowList.topRatedTV)
                }.pickerStyle(SegmentedPickerStyle())
                ScrollViewMoviesShow(arrayDataFromAPI: tvShowViewModel.tvShowFromRealm, genresDictionary: genresModel.dictionaryGenresFromRealm)
            }.alert(item: self.$tvShowViewModel.tvShowError) { error in
                Alert(title: Text("Network error TV shows"),
                      message: Text(error.localizedDescription),
                      dismissButton: .default(Text("OK")))
            }
            .alert(item: self.$genresModel.errorGenres) { error in
                Alert(title: Text("Network error TV show genres"),
                      message: Text(error.localizedDescription),
                      dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle(LocalizedStringKey("TV Show"), displayMode: .inline)
            .navigationBarItems(
                //              leading:
                //                        HStack {
                //                             Button(action: {
                //                              FileManager.clearAllFile()
                //                            //delete all files from file manager and realm database file
                //                            //print("FileManager clear")
                //                              }) {
                //                              Image(systemName: "trash")
                //                               .resizable()
                //                               .frame(width: 23, height: 23)
                //                               .padding()
                //                   }},
                trailing:
                    HStack {
                        Button(action: {
                            self.showFilters.toggle()
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .resizable()
                                .frame(width: 23, height: 23)
                                .padding()
                        }
                    })
            .actionSheet(isPresented: $showFilters) {
                ActionSheet(title: Text("Choose filters"), message: Text("Filter by:"), buttons: [
                    .default(Text(LocalizedStringKey("Date"))) {
                        tvShowViewModel.filteringMoviesIndex = FilterContent.FilteredParameters.releaseDate },
                    .default(Text(LocalizedStringKey("Name"))) {
                        tvShowViewModel.filteringMoviesIndex = FilterContent.FilteredParameters.title },
                    .default(Text(LocalizedStringKey("Rating"))) {
                        tvShowViewModel.filteringMoviesIndex = FilterContent.FilteredParameters.rating },
                    .default(Text(LocalizedStringKey("Popularity"))) {
                        tvShowViewModel.filteringMoviesIndex = FilterContent.FilteredParameters.popularity },
                    .cancel()
                ])
            }
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
                    SectionView(section: show, genresDictionary: self.genresDictionary, mappersForView: MappersForView())
                }
                //.opacity(0.0)
                //.buttonStyle(PlainButtonStyle())
            }
        }
    }
}
