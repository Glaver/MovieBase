//
//  GridView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct GridView: View {
    var arrayOfData: [MovieModel]
    let columns = [GridItem(.adaptive(minimum: 200))]

    var body: some View {
        ScrollView {

            LazyVGrid(columns: columns) {
                ForEach(arrayOfData, id: \.self) { content in
                    NavigationLink(destination: MovieDetailView(movie: content)) {
                        VStack {
                            ImageView(imageLoader: ImageLoaderService(url: content.posterPath, imageSize: ImageAPI.Size.medium), imagePath: content.posterPath, imageCache: ImageLoaderCache.shared)
                                .frame(width: 180, height: 270, alignment: .top)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                                .shadow(color: Color.blue.opacity(0.5), radius: 20, x: 0, y: 10)
                            Text(content.title)
                                .font(.system(size: 20))
                                .foregroundColor(.blue)
                                .frame(width: 180, height: 70, alignment: .center)
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                        }
                    }
                }
            }
        }
    }
}
