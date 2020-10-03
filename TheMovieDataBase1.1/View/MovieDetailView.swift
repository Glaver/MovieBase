//
//  MovieDetail.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 11/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    var movie = MovieModel(id: 0, title: "", backdropPosterPath: "", posterPath: "", genres: [0], overview: "", releaseDate: Date.init("2020-10-09"), rating: 0)
    
    var body: some View {
        ScrollView(.vertical){
            VStack {
                ZStack(alignment: .bottomLeading) {
                    VStack {
                        ImageViewModel(imageLoader: ImageLoaderViewModel(url: ImageAPI.Size.original.path(poster: (movie.backdropPosterPath ?? ""))), imageName: movie.backdropFilemanagerName)
                            .frame(width:500,height:281, alignment: .top)
                            .aspectRatio(contentMode: .fill)
                            .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                        
                        Rectangle()
                            .fill(Color.white)
                            .opacity(0.1)
                            .frame(height: 100)
                    }
                    HStack{
                        Spacer(minLength: 20)
                            ImageViewModel(imageLoader: ImageLoaderViewModel(url: ImageAPI.Size.cast.path(poster: (movie.posterPath ?? ""))), imageName: movie.posterFilemanagerName)
                            .frame(width:140, height:210, alignment: .leading)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.5), radius: 20, x: 0, y: 10)
                        
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.system(size: 19))
                                .bold()
                                .lineLimit(3)
                                .frame(width:250, alignment: .leading)
                            Text(movie.releaseDate.printFormattedDate(format: "MMM dd,yyyy"))
                                .font(.system(size: 17))
                        }
                        .offset(y: 45)
                        Spacer()
                    }
                }
                VStack(alignment: .leading) {
                    Text("Overview")
                        .font(.system(size: 25))
                        .bold()
                    Text(movie.overview)
                        .frame(width:370, alignment: .leading)
                        .font(.system(size: 24))
                   
                }
                
                
                
            }
            
            CastList(castsViewModel: CastViewModel(movieId: movie.id))
        
        }
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView()
    }
}
