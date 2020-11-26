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
                ContentHeadImagesTitlePoster(section: tvShowViewModel.tvShowDetailFromRealm, mappersForView: MappersForView())
                GenresBlock(genres: tvShowViewModel.tvShowDetailFromRealm.genres, mappersForView: MappersForView())
                InfoDetailContentView(section: tvShowViewModel.tvShowDetailFromRealm)
                Overview(overviewText: tvShowViewModel.tvShowDetailFromRealm.overview)
                VideoView(videoViewModel: MovieVideoViewModel(movieId: tvShow.id, endpoint: Endpoint.videosTV(tvShowID: tvShow.id)))
                CastList(castsViewModel: CastViewModel(movieId: tvShow.id, chooseEndpoint: CastViewModel.EndpointTvOrMovie.tvShow, realmService: CreditsRealm(), mappers: CreditsMappers()))
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
        self.tvShowViewModel = TvShowDetailViewModel(tvShowId: tvShow.id, realmService: TvShowDetailsRealm(), mappers: TvShowDetailsMappers())
    }
}

//struct TvShowDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TvShowDetailView()
//    }
//}
