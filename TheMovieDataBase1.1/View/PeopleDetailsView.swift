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
                ImageView(imageLoader: ImageLoaderService(url: viewModel.peopleDetail.profilePath, imageSize: .original), imagePath: viewModel.peopleDetail.profilePath, imageCache: ImageLoaderCache.shared)
                    .frame(width: 350, height: 550)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
                    //.shadow(color: Color.blue.opacity(0.7), radius: 20, x: 0, y: 10)
                VStack {
                    Text(viewModel.peopleDetail.name)
                        .bold()
                        .font(.system(size: 25))
                    Text(viewModel.peopleDetail.placeOfBirth ?? "")
                        .bold()
                }
                GenresBlock(arrayOfContent: viewModel.peopleDetail.alsoKnownAs)
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
