//
//  ContentView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 5/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel = MovieViewModel(indexOfMoviesList: MoviesList.nowPlaying, filteringMoviesIndex: FilterContent.FilteredParameters.releaseDate, realmService: MovieListRealm(), mappers: MovieMappers(), filter: FilterContent())
    @ObservedObject var genresModel = GenreViewModel(genresEndpoint: Endpoint.movieGenres, realmService: GenresRealm(), mappers: GenresMappers())
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
                            ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, genresDictionary: genresModel.dictionaryGenresFromRealm)
                        }
                    } else {
                        ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, genresDictionary: genresModel.dictionaryGenresFromRealm)
                    }
                    if self.showFilters {
                        VStack(alignment: .center, spacing: 40) {
                            Picker("", selection: $viewModel.filteringMoviesIndex) {
                                Text(LocalizedStringKey("Date")).tag(FilterContent.FilteredParameters.releaseDate)
                                    .font(.system(size: 25))
                                    .foregroundColor(.blue)
                                Text(LocalizedStringKey("Name")).tag(FilterContent.FilteredParameters.title)
                                    .font(.system(size: 25))
                                    .foregroundColor(.blue)
                                Text(LocalizedStringKey("Rating")).tag(FilterContent.FilteredParameters.rating)
                                    .font(.system(size: 25))
                                    .foregroundColor(.blue)
                                Text(LocalizedStringKey("Popularity")).tag(FilterContent.FilteredParameters.popularity)
                                    .font(.system(size: 25))
                                    .foregroundColor(.blue)
                                    }
                        }
                        .frame(width: 130, height: 130)
                        .padding()
                        .background(Color.white.opacity(0.8))
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
/*            .actionSheet(isPresented: $showFilters) {
 ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
     .default(Text(LocalizedStringKey("Date"))) { self.$viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.releaseDate },
     .default(Text(LocalizedStringKey("Name"))) { self.$viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.name },
     .default(Text(LocalizedStringKey("Rating"))) { self.$viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.rating },
     .default(LocalizedStringKey("Popularity")) { self.$viewModel.filteringMoviesIndex = FilterContent.FilteredParameters.popularity },
     .cancel()
 ])
}*/

/*trailing: Image(systemName: "slider.horizontal.3")
 .resizable()
 .frame(width: 23, height: 23)
 .padding()
 .onTapGesture {
     self.showFilters = true
 }*/
