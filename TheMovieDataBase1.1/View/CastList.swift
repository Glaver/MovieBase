//
//  CastList.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 29/9/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct CastList: View {
    @ObservedObject var castsViewModel: CastViewModel
    var body: some View {
        VStack {
            Text(LocalizedStringKey("Movie cast"))
                .font(.system(size: 22))
                .bold()
                .padding(.top)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(castsViewModel.castAndCrewFromRealm.cast) { cast in
                        //GeometryReader { _ in
                        NavigationLink(destination: PeopleDetailsView(viewModel: PeopleDetailsViewModel(personId: cast.id))) {
                            VStack {
                                ImageView(imageLoader: ImageLoaderService(url: cast.profilePath, imageSize: .cast), imagePath: cast.profilePath, imageCache: ImageLoaderCache.shared)
                                    .frame(width: 130, height: 195, alignment: .top)
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(10)
                                    .shadow(color: Color.blue.opacity(0.2), radius: 20, x: 0, y: 10)
                                Text("\(cast.name)")
                                    .lineLimit(2)
                                Text("\(cast.character)")
                                    .frame(width: 130, height: 80, alignment: .top)
                                    .lineLimit(3)
                                    .font(.footnote)
                            }
                            //                    .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20), axis: (x: 0, y: 40, z: 0)
                        }.frame(width: 130, height: 280, alignment: .top)
                        //}
                    }
                }
            }
            .frame(width: 370, height: 310) //
        }
    }
}
