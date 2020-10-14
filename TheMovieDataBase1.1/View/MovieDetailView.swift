//
//  MovieDetail.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 11/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel : MovieDetailViewModel
    var movie = MovieModel(popularity: 0, id: 0, title: "", backdropPosterPath: "", posterPath: "", genres: [0], overview: "", releaseDate: Date.init("2020-10-09"), rating: 0)
    
    
    var body: some View {
        ScrollView(.vertical){
            VStack {
                ZStack(alignment: .bottomLeading) {
                    VStack {
                        ImageViewModel(imageLoader: ImageLoaderViewModel(url: ImageAPI.Size.original.path(poster: (movie.backdropPosterPath ?? ""))), imageName: movie.backdropFilemanagerName)
                            .frame(height:250, alignment: .center)//width:450,
                            //.aspectRatio(contentMode: .fill)
                            .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                            
                        Rectangle()
                            .fill(Color.white)
                            .opacity(0.1)
                            .frame(height: 100)
                    }
                    HStack{
                        ImageViewModel(imageLoader: ImageLoaderViewModel(url: ImageAPI.Size.cast.path(poster: (movie.posterPath ?? ""))), imageName: movie.posterFilemanagerName)
                            .frame(width:130, height:190, alignment: .leading)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.5), radius: 20, x: 0, y: 10)
                            .padding(.leading, 5)
                        
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.system(size: 19))
                                .bold()
                                .lineLimit(3)
                                .frame(width:200, alignment: .leading)
                            Text(movie.releaseDate.printFormattedDate(format: "MMM dd,yyyy"))
                                .font(.system(size: 17))
                        }
                        .offset(y: 45)
                    }
                    
                }
                VStack(alignment: .center) {
                    Text("  " + "Overview")
                        .font(.system(size: 25))
                        .bold()
                    Text(viewModel.movieDetailsFromRealm.overview ?? movie.overview)
                        .frame(alignment: .center)//width:370,
                        .font(.system(size: 24))
                        .padding()
                }
                Text("Budget: $\(viewModel.movieDetail.budget)")
                
                
                VideoView(videoViewModel: MovieVideoViewModel(movieId: movie.id))
                Text("Movie cast")
                    .font(.system(size: 22))
                    .bold()
                CastList(castsViewModel: CastViewModel(movieId: movie.id))
            }
        }
    }
    init(movie: MovieModel) {
        self.movie = movie
        self.viewModel = MovieDetailViewModel(movieId: movie.id)
    }
}

//struct MovieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
