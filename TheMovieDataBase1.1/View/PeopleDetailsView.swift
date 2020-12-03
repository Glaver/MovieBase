//
//  PeopleDetailsView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 30/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct PeopleDetailsView: View {
    @ObservedObject var viewModel: PeopleDetailsViewModel
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                VStack(alignment: .leading ) {
                    HStack(alignment: .center, spacing: 10) {
                        ImageView(imageLoader: ImageLoaderService(url: viewModel.peopleDetail.profilePath, imageSize: .cast), imagePath: viewModel.peopleDetail.profilePath, imageCache: ImageLoaderCache.shared)
                            .frame(width: 150, height: 220)
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10)
                            .shadow(color: Color.blue.opacity(0.7), radius: 20, x: 0, y: 10)
                            .padding(15)
                        VStack {
                            Text(viewModel.peopleDetail.name)
                                .bold()
                                .font(.system(size: 25))
                            Text(viewModel.peopleDetail.placeOfBirth ?? "")
                                .bold()
                        }
                    }
                }
                GenresBlock(arrayOfContent: viewModel.peopleDetail.alsoKnownAs)
                InfoDetailContentView(section: viewModel.peopleDetail)
                Overview(overviewText: viewModel.peopleDetail.biography)
            }
        }
    }
}


//struct PeopleDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PeopleDetailsView()
//    }
//}
