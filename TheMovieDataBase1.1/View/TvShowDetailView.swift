//
//  TvShowDetailView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 4/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct TvShowDetailView: View {
    @ObservedObject var tvShowViewModel: TvShowDetailViewModel
    var tvShow: ResultTvModel

    var body: some View {
        ScrollView(.vertical) {
            VStack {
//                ContentHeadImagesTitlePoster(backdropPath: tvShow.backdropPath,
//                                             backdropFilemanagerName: tvShow.backdropFileManagerName,
//                                             posterPath: tvShow.posterPath,
//                                             posterFilemanagerName: tvShow.posterFileManagerName,
//                                             tagline: tvShowViewModel.tvShowDetail.tagline,
//                                             title: tvShow.name,
//                                             originalTitle: tvShow.originalName)
                Text(tvShowViewModel.tvShowDetail.originalName)
                //Text(tvShowViewModel.tvShowDetail.)
                Overview(overviewText: tvShowViewModel.tvShowDetail.overview)
                //VideoView(videoViewModel: MovieVideoViewModel(movieId: tvShow.id, endpoint: Endpoint.videosTV(tvShowID: tvShow.id)))
//                CastList(castsViewModel: CastViewModel(movieId: tvShow.id, castAndCrew: MovieCreditResponse(cast: [MovieCast](), crew: [MovieCrew]()), endpoint: Endpoint.creditsTV(tvShowID: tvShow.id)))
            }
        }
        .alert(item: self.$tvShowViewModel.tvShowDetailError) { error in
            Alert(title: Text("Network error"),
                  message: Text(error.localizedDescription),
                  dismissButton: .default(Text("OK")))
        }
    }
    init(tvShow: ResultTvModel) {
        self.tvShow = tvShow
        self.tvShowViewModel = TvShowDetailViewModel(tvShowId: tvShow.id)
    }
}

//struct TvShowDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TvShowDetailView()
//    }
//}
