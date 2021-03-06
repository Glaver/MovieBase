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
    var mappersForView = MappersForView()

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ContentHeadImagesTitlePoster(section: viewModel.movieDetailsFromRealm, mappersForView: MappersForView())
                GenresBlock(arrayOfContent: mappersForView.convertsToArrayString(from: viewModel.movieDetailsFromRealm.genres))//genres: viewModel.movieDetailsFromRealm.genres, mappersForView: MappersForView())
                InfoDetailContentView(section: viewModel.movieDetailsFromRealm)
                Overview(overviewText: viewModel.movieDetailsFromRealm.overview ?? movie.overview)
                VideoView(videoViewModel: MovieVideoViewModel(movieId: movie.id, videoContentFor: MovieVideoViewModel.CategoryVideo.movie))
                BoxOfficeView(budget: viewModel.movieDetailsFromRealm.budget, revenue: viewModel.movieDetailsFromRealm.revenue)
                CastList(castsViewModel: CastViewModel(movieId: movie.id, castListFor: CastViewModel.CategoryCast.movie, realmService: CreditsRealm(), mappers: CreditsMappers()))
            }
        }.alert(item: self.$viewModel.movieDetailError) { error in
            Alert(title: Text("Network error"),
                  message: Text(error.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
    }
    init(movie: MovieModel) {
        self.movie = movie
        self.viewModel = MovieDetailViewModel(movieId: movie.id, realmService: MovieDetailsRealm(), mappers: MovieDetailsMappers())
    }
}

// MARK: ContentHead Backdrop Poster Title
struct ContentHeadImagesTitlePoster: View {
    let section: DetailViewHeadImagesTitleProtocol
    let mappersForView: MappersForViewProtocol
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                ZStack {
                    ImageView(imageLoader: ImageLoaderService(url: section.backdropPath, imageSize: .medium), imagePath: section.backdropPath, imageCache: ImageLoaderCache.shared)
                        .frame(height: 250, alignment: .center)//width:450,
                        .shadow(color: Color.blue.opacity(0.3), radius: 20, x: 0, y: 10)
                    TaglineView(tagline: section.tagline ?? "NO")
                }
                Rectangle()
                    .fill(Color.clear)
                    .opacity(0.1)
                    .frame(height: 110)
            }
            HStack {
                ImageView(imageLoader: ImageLoaderService(url: section.posterPath, imageSize: .cast), imagePath: section.posterPath, imageCache: ImageLoaderCache.shared)
                    .frame(width: 130, height: 190, alignment: .leading)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.7), radius: 20, x: 0, y: 10)
                    .padding(.leading, 5)

                VStack(alignment: .leading, spacing: 5) {
                    Text(section.title)
                        .font(.system(size: 22))
                        .bold()
                        .lineLimit(3)
                        .frame(width: 230, alignment: .leading)
                    Text(mappersForView.originalTitle(section.originalTitle, vs: section.title))
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
    let arrayOfContent: [String]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(arrayOfContent, id: \.self) { genre in
                    Text(genre.capitalizingFirstLetter())
                        .font(.system(size: 16))
                        .lineLimit(1)
                        .padding(5)
                        .background(Color.gray.opacity(0.2))
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
    var section: InfoDetailContentViewProtocol
    var body: some View {
        Divider()
        Spacer()
        HStack(alignment: .center, spacing: 10) {
            if section.releaseDate != Date() {
                VStack {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(.red)
                    Text(DateFormattingHelper.shared.printFormattedDate(section.releaseDate, printFormat: "MMM dd,yyyy"))
                        .font(Font.body.bold())
                        .foregroundColor(Color.blue)
                }.frame(width: 110, height: 70, alignment: .center)
            }
            if section.voteAverage != 0 {
                VStack {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(.yellow)
                    Text(String(round(10 * section.voteAverage)/10))
                        .font(Font.body.bold())
                        .frame(width: 40, height: 25)
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: Color.yellow.opacity(0.4), radius: 10, x: 0, y: 10)
                }.frame(width: 80, height: 70, alignment: .center)
            }
            if section.runtime != nil && section.runtime != 0 {
                VStack {
                    Image(systemName: "clock")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(Color.purple)
                    HStack {
                        Text(String(section.runtime!))
                        Text(LocalizedStringKey("min"))
                    }.font(Font.body.bold())
                }.frame(width: 80, height: 70, alignment: .center)
            }
            if section.homepage != nil {
                VStack {
                    if let url = URL(string: section.homepage!) {
                        if #available(iOS 14.0, *) {
                            Link(destination: url) {
                                VStack {
                                    Image(systemName: "link")
                                        .resizable()
                                        .frame(width: 30, height: 30, alignment: .center)
                                        .foregroundColor(Color.blue)
                                    Text("Homepage")
                                        .font(Font.body.bold())
                                }.frame(width: 100, height: 70, alignment: .center)
                            }
                        } else {
                            Button(action: {
                                UIApplication.shared.open(url)
                            }) {
                                Image(systemName: "network")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                    .foregroundColor(Color.blue)
                                Text(LocalizedStringKey("Homepage"))
                                    .font(Font.body.bold())
                            }.frame(width: 100, height: 70, alignment: .center)
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
        VStack(alignment: .center) {
            Text(LocalizedStringKey("Overview"))
                .font(.system(size: 22))
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
