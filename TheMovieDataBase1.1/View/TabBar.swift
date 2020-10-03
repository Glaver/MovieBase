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
                Image(systemName: "play")
                Text("Movies")
            }
            SearchView().tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
