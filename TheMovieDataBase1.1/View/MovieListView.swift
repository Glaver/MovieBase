//
//  ContentView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 5/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var genresModel = GenreViewModel(genresEndpoint: Endpoint.movieGenres,
                                                     realmService: GenresRealm(),
                                                     mappers: GenresMappers())
    @ObservedObject var viewModel = MovieViewModel(indexOfMoviesList: MoviesList.topRated,
                                                   filteringMoviesIndex: FilterContent.FilteredParameters.releaseDate,
                                                   realmService: MovieListRealm(),
                                                   mappers: MovieMappers(),
                                                   filter: FilterContent())
    @State var showFilters = false
    @State var isGrid = false
    private func changeButton(_ isList: Bool) -> String {
        if isList {
            return "square.fill.text.grid.1x2"
        } else {
            return "square.grid.2x2"
        }
    }
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $viewModel.indexOfMoviesList) {
                    Text(LocalizedStringKey("Now Playing")).tag(MoviesList.nowPlaying)
                    Text(LocalizedStringKey("Popular")).tag(MoviesList.popular)
                    Text(LocalizedStringKey("Upcoming")).tag(MoviesList.upcoming)
                    Text(LocalizedStringKey("Top Rated")).tag(MoviesList.topRated)
                }
                .pickerStyle(SegmentedPickerStyle())
                if isGrid {
                    if #available(iOS 14.0, *) {
                        GridView(arrayOfData: viewModel.moviesFromRealm)
                    } else {
                        ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, genresDictionary: genresModel.dictionaryGenresFromRealm)
                    }
                } else {
                    ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, genresDictionary: genresModel.dictionaryGenresFromRealm)
                }
            }
            .alert(item: self.$viewModel.moviesError) { error in
                Alert(title: Text("Network error"),
                      message: Text(error.localizedDescription),
                      dismissButton: .default(Text("OK")))
            }
            .alert(item: self.$genresModel.errorGenres) { error in
                Alert(title: Text("Network error"),
                      message: Text(error.localizedDescription),
                      dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle(LocalizedStringKey("Movies"), displayMode: .inline)
            .navigationBarItems(leading:
                                    HStack {
                                        Button(action: {
                                            isGrid.toggle()
                                        }) {
                                            Image(systemName: changeButton(isGrid))
                                                .resizable()
                                                .frame(width: 23, height: 23)
                                                .padding()
                                        }
                                    }, trailing:
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
                        viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.releaseDate },
                    .default(Text(LocalizedStringKey("Name"))) {
                        viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.title },
                    .default(Text(LocalizedStringKey("Rating"))) {
                        viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.rating },
                    .default(Text(LocalizedStringKey("Popularity"))) {
                        viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.popularity },
                    .cancel()
                ])
            }
        }
    }
}

struct ScrollViewMovies: View {
    var arrayDataFromAPI: [MovieShowViewProtocol]
    var genresDictionary: GenresDictionaryProtocol
    var body: some View {
        VStack {
            List(self.arrayDataFromAPI, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie as! MovieModel)) {
                    SectionView(section: movie, genresDictionary: self.genresDictionary, mappersForView: MappersForView())
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieListView()
//    }
//}
