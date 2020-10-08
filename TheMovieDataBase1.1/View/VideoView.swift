//
//  VideoView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct VideoView: View {
    @ObservedObject var videoViewModel: MovieVideoViewModel
    var body: some View {
        if videoViewModel.videos.isEmpty{
        } else {
            Text("Trailers")
                .font(.system(size: 25))
                .bold()
        }
        ScrollView(.horizontal) {
            Divider()
            HStack(spacing: 15) {
                ForEach(videoViewModel.videos) { video in
                    VStack {
                        if video.site == "YouTube"{
                        WebView(request: URLRequest(url: URL(string: "https://www.youtube.com/embed/\(video.key)")!))
                            .frame(width:337, height:190, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                        Text(video.name)
                            .lineLimit(3)
                            .frame(width:337, height:45, alignment: .center)
                            .multilineTextAlignment(.center)
                        }
                    }
                }
            }
            Divider()
        }
        .frame(width:350, alignment: .center)
    }
}
