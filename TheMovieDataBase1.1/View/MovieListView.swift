//
//  ContentView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 5/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI
import RealmSwift

struct MovieListView: View {
    @ObservedObject var viewModel = MovieViewModel(indexOfMoviesList: MoviesList.nowPlaying, filteringMoviesIndex: FilterMovies.releaseDate)
    @ObservedObject var genresModel = GenreViewModel(genresEndpoint: Endpoint.movieGenres)
    @State var showFilters = false
    @State var isGrid = false

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
                ZStack(alignment: .topTrailing, content: {
                    if isGrid {
                        if #available(iOS 14.0, *) {
                            GridView(arrayOfData: viewModel.moviesFromRealm)
                        } else {
                            ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, genresDictionary: genresModel.dictionaryGenresRealm)
                        }
                    } else {
                        ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, genresDictionary: genresModel.dictionaryGenresRealm)
                    }
                    if self.showFilters {
                        VStack(alignment: .center, spacing: 40) {
                            Picker("", selection: $viewModel.filteringMoviesIndex) {
                                Text(LocalizedStringKey("Date")).tag(FilterMovies.releaseDate).font(.system(size: 25))
                                Text(LocalizedStringKey("Name")).tag(FilterMovies.title).font(.system(size: 25))
                                Text(LocalizedStringKey("Rating")).tag(FilterMovies.rating).font(.system(size: 25))
                                Text(LocalizedStringKey("Popularity")).tag(FilterMovies.popularity).font(.system(size: 25))
                                    }
                        }
                        .frame(width: 130, height: 130)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(15)
                        .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                    }

                })
            }.alert(item: self.$viewModel.moviesError) { error in
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

func changeButton(_ isList: Bool) -> String {
    if isList {
        return "square.fill.text.grid.1x2"
    } else {
        return "square.grid.2x2"
    }
}
//ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, genresDictionary: genresModel.dictionaryGenresRealm)

//GridView(arrayOfData: viewModel.moviesFromRealm)

struct ScrollViewMovies: View {
    var arrayDataFromAPI: [MovieModel]
    var genresDictionary: GenresDictionary

    var body: some View {
        VStack {
            List(self.arrayDataFromAPI, id: \.id) { item in
                NavigationLink(destination: MovieDetailView(movie: item)) {
                    SectionView(section: item, inputURLforImage: ImageAPI.Size.medium.path(poster: (item.posterPath ?? "")), genresDictionary: self.genresDictionary)
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
