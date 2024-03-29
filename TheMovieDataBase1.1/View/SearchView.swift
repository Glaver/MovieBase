//
//  SearchView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 28/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    var onCommit: () -> Void = { print("onCommit") }

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                // Search text field
                ZStack(alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text(LocalizedStringKey("Search"))
                    }
                    TextField("", text: $searchText, onEditingChanged: { _ in
                        self.showCancelButton = true
                    }, onCommit: onCommit).foregroundColor(.primary)
                }
                // Clear button
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary) // For magnifying glass and placeholder test
                .background(Color(.tertiarySystemFill))
                .cornerRadius(10.0)

            if showCancelButton {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}
//SearchTvShowViewModel
struct SearchView: View {
    @ObservedObject var searchTvShowModel = SearchTvShowViewModel()
    @ObservedObject var searchMovieModel = SearchMovieViewModel()
    @ObservedObject var genresModel = GenreViewModel(genresEndpoint: Endpoint.movieGenres, realmService: GenresRealm(), mappers: GenresMappers())
    enum ContentSearch {
        case movie
        case tvShow
    }
    @State var contentType: ContentSearch = .movie
    var body: some View {
        NavigationView {
            VStack {
                if contentType == .movie {
                    SearchBarView(searchText: $searchMovieModel.name)
                } else if contentType == .tvShow {
                    SearchBarView(searchText: $searchTvShowModel.name)
                }
                Picker("", selection: $contentType) {
                    Text(LocalizedStringKey("Movies")).tag(ContentSearch.movie)
                    Text(LocalizedStringKey("TV Show")).tag(ContentSearch.tvShow)
                }.pickerStyle(SegmentedPickerStyle())
                if contentType == .movie {
                    ScrollViewMovies(arrayDataFromAPI: searchMovieModel.moviesDTO, genresDictionary: genresModel.dictionaryGenresFromRealm)
                } else if contentType == .tvShow {
                    ScrollViewMoviesShow(arrayDataFromAPI: searchTvShowModel.tvShow, genresDictionary: genresModel.dictionaryGenresFromRealm)
                }
            }
            .navigationBarTitle(LocalizedStringKey("Search"))//, displayMode: .inline)
        }
    }
}
//ScrollViewMoviesShow
struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged {_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
