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
    @ObservedObject var genresModel = GanreViewModel(genresEndpoint: Endpoint.movieGenres)
    @State var showFilters = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $viewModel.indexOfMoviesList) {
                    Text("Now Playing").tag(MoviesList.nowPlaying)
                    Text("Popular").tag(MoviesList.popular)
                    Text("Upcoming").tag(MoviesList.upcoming)
                    Text("Top Rated").tag(MoviesList.topRated)
                }
                .pickerStyle(SegmentedPickerStyle())
                ZStack(alignment: .topTrailing, content: {
                    ScrollViewMovies(arrayDataFromAPI: viewModel.moviesFromRealm, ganresDictionary: genresModel.dictionaryGanresRealm)
                    if self.showFilters {
                        VStack(alignment: .center, spacing: 40) {
                            Picker("", selection: $viewModel.filteringMoviesIndex) {
                                Text("Date").tag(FilterMovies.releaseDate).font(.system(size: 25))
                                Text("Name").tag(FilterMovies.title).font(.system(size: 25))
                                Text("Rating").tag(FilterMovies.rating).font(.system(size: 25))
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
                Alert(title: Text("Network error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))
                }
            .navigationBarTitle("Movies", displayMode: .inline)
            .navigationBarItems(leading:
                                    HStack {
                                        Button(action: {
                                            FileManager.clearAllFile()
                                            //delete all files from filemangaer and realm database file
                                            //print("FileManager clear")
                                        }) {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .frame(width: 23, height: 23)
                                                .padding()
                                        }
                             }, trailing:
                                    HStack{
                                        Button(action: {
                                            withAnimation(.spring()){
                                                self.showFilters.toggle()
                                            }
                                        }) {
                                            Image(systemName: "shuffle")
                                                .resizable()
                                                .frame(width: 23, height: 23)
                                                .padding()
                                            }
                                })
            
        }
    }
    
}


struct ScrollViewMovies: View {
    var arrayDataFromAPI: [MovieModel]
    var ganresDictionary: GenresDictionary
    
    var body: some View {
            VStack {
                List(self.arrayDataFromAPI,  id: \.id){ item in
                    NavigationLink(destination: MovieDetailView(movie: item)){
                        SectionView(section: item, inputURLforImage: ImageAPI.Size.original.path(poster: (item.posterPath ?? "")), ganresDictionary: self.ganresDictionary)
                    }
                }
        }
    }
}


struct SectionView: View {
    var section: MovieModel
    let inputURLforImage: URL?
    let ganresDictionary: GenresDictionary
    var body: some View {
        HStack {
            ImageViewModel(imageLoader: ImageLoaderViewModel(url: inputURLforImage), imageName: section.posterFilemanagerName)
                            .frame(width:130, height:195, alignment: .top)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(5)
                            .shadow(color: Color.blue.opacity(0.5), radius: 20, x: 0, y: 10)
            
            VStack(alignment: .leading) {
                Text(section.title)
                    .font(.system(size: 18))
                    .bold()
                    .frame(width: 220, height: 70, alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                Text(Mappers.convertorGenresToString(ganresDict: ganresDictionary, genresOfMovie: section.genres))
                    .frame(width: 150, alignment: .leading)
                Spacer()
                HStack {
                    Text(section.releaseDate.printFormattedDate(format: "MMM dd,yyyy"))
                        .foregroundColor(Color.blue)
                    Spacer()
                    Text(String(section.rating))
                        .font(Font.body.bold())
                        
                        .frame(width: 40, height: 25)
                        .background(Color.yellow)
                        .cornerRadius(14)
                        .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.black.opacity(0.2), lineWidth: 1)
                                )
                        .shadow(color: Color.yellow.opacity(0.4), radius: 14, x: 0, y: 10)
                }
                .frame(width: 205)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
