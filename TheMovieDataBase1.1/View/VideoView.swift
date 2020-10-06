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
        Text("Here should be trailers")
            .frame(width: 370, height: 120, alignment: .center)
    }
}

//struct VideoView_Previews: PreviewProvider {
//    static var previews: some View {
//        VideoView()
//    }
//}
