//
//  TabBar.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 28/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            MovieListView().tabItem {
                Image(systemName: "film")
                Text(LocalizedStringKey("Movies"))
            }

            TvShowListView().tabItem {
                Image(systemName: "tv")
                Text("TV Show")
            }

            SearchView().tabItem {
                Image(systemName: "magnifyingglass")
                Text(LocalizedStringKey("Search"))
            }
        }
    }
}

//struct TabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBar()
//    }
//}
