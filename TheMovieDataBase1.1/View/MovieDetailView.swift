//
//  MovieDetail.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 11/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//
import Foundation
import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    var movie: MovieModel

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ContentHeadImagesTitlePoster(backdropPath: viewModel.movieDetailsFromRealm.backdropPath,
                                             backdropFilemanagerName: viewModel.movieDetailsFromRealm.backdropFilemanagerName,
                                             posterPath: viewModel.movieDetailsFromRealm.posterPath,
                                             posterFilemanagerName: viewModel.movieDetailsFromRealm.posterFilemanagerName,
                                             tagline: viewModel.movieDetailsFromRealm.tagline,
                                             title: viewModel.movieDetailsFromRealm.title,
                                             originalTitle: viewModel.movieDetailsFromRealm.originalTitle)

                GenresBlock(genres: viewModel.movieDetailsFromRealm.genres)

                InfoDetailContentView(releaseDate: viewModel.movieDetailsFromRealm.releaseDate,
                                      voteAverage: viewModel.movieDetailsFromRealm.voteAverage,
                                      runtime: viewModel.movieDetailsFromRealm.runtime,
                                      homepage: viewModel.movieDetailsFromRealm.homepage)
                Overview(overviewText: viewModel.movieDetailsFromRealm.overview ?? movie.overview)
                //VStack{
                VideoView(videoViewModel: MovieVideoViewModel(movieId: movie.id, endpoint: Endpoint.videos(movieID: movie.id)))//(fromEndpoint: Endpoint.videos(movieID: movie.id) ))
                    BoxOfficeView(budget: viewModel.movieDetailsFromRealm.budget, revenue: viewModel.movieDetailsFromRealm.revenue)
                CastList(castsViewModel: CastViewModel(movieId: movie.id, castAndCrew: MovieCreditResponse(cast: [MovieCast](), crew: [MovieCrew]())))

                //}

            }
        }.alert(item: self.$viewModel.movieDetailError) { error in
            Alert(title: Text("Network error"),
                  message: Text(error.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
    }
    init(movie: MovieModel) {
        self.movie = movie
        self.viewModel = MovieDetailViewModel(movieId: movie.id)
    }
}

// MARK: ContentHead Backdrop Poster Title
struct ContentHeadImagesTitlePoster: View {
    var backdropPath: String?
    var backdropFilemanagerName: String
    var posterPath: String?
    var posterFilemanagerName: String
    var tagline: String?
    var title: String
    var originalTitle: String

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                ZStack {
                    ImageViewModel(imageLoader: ImageLoaderViewModel(url: ImageAPI.Size.original.path(poster: (backdropPath ?? ""))), imageName: backdropFilemanagerName)
                        .frame(height: 270, alignment: .center)//width:450,
                        .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                    TaglineView(tagline: tagline ?? "NO")
                }
                Rectangle()
                    .fill(Color.clear)
                    .opacity(0.1)
                    .frame(height: 110)
            }
            HStack {
                ImageViewModel(imageLoader: ImageLoaderViewModel(url: ImageAPI.Size.medium.path(poster: (posterPath ?? ""))), imageName: posterFilemanagerName)
                    .frame(width: 130, height: 190, alignment: .leading)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.7), radius: 20, x: 0, y: 10)
                    .padding(.leading, 5)

                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.system(size: 22))
                        .bold()
                        .lineLimit(3)
                        .frame(width: 230, alignment: .leading)
                    Text(Mappers.originalTitle(originalTitle, vs: title))
                        .font(.system(size: 20))
                        .bold()
                        .lineLimit(2)
                        .frame(width: 230, alignment: .leading)

                }
                .offset(y: 45)
            }
        }
    }
}
// MARK: GenresBlock
struct GenresBlock: View {
    let genres: [GenresDTO]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
        HStack {
            ForEach(Mappers.convertsToArrayString(from: genres), id: \.self) { genre in
                Text(genre)
                    .font(.system(size: 15))
                    .lineLimit(1)
                    .padding(5)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(5)
            }
            Spacer()
        }
        .padding(15)
        Spacer()
    }
    }
}
// MARK: InfoDetailContentView
struct InfoDetailContentView: View {
    let releaseDate: Date
    let voteAverage: Float
    let runtime: Int?
    let homepage: String?

    var body: some View {
        Divider()
        Spacer()
        HStack(alignment: .center, spacing: 30) {
            VStack {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.red)
                Text(DateFormattingHelper.shared.printFormattedDate(releaseDate, printFormat: "MMM dd,yyyy"))
                    //.foregroundColor(Color.blue)
                    .font(Font.body.bold())
                    .foregroundColor(Color.blue)
            }
            VStack {
                if voteAverage != 0 {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(.yellow)
                    Text(String(voteAverage))
                        .font(Font.body.bold())

                        .frame(width: 40, height: 25)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: Color.yellow.opacity(0.4), radius: 10, x: 0, y: 10)
                }
            }
            VStack {
                if runtime != nil {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(Color.purple)
                    Text(Mappers.convertsIntToHoursAndMin(timeInMin: runtime))
                        .font(Font.body.bold())
                }
            }
            VStack {
                if let url = URL(string: homepage!) {
                    if #available(iOS 14.0, *) {
                        Link(destination: url) {
                            VStack {
                                Image(systemName: "network")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(Color.blue)
                                Text("Homepage")
                                    .font(Font.body.bold())
                            }
                        }
                    } else {
                        Button(action: {
                            UIApplication.shared.open(url)
                        }) {
                            Image(systemName: "network")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(Color.blue)
                            Text("Homepage")
                                .font(Font.body.bold())
                        }
                    }
                }
            }
        }
        Spacer()
        Divider()
    }
}
// MARK: Overview
struct Overview: View {
    var overviewText: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey("Overview"))
                .font(.system(size: 25))
                .bold()
                .padding(.bottom)
            Text(overviewText)
                .layoutPriority(1)
                .fixedSize(horizontal: false, vertical: true)
                .frame(alignment: .center)//width:370,
                .font(.system(size: 24))
        }.padding()
    }
}

//struct MovieDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
