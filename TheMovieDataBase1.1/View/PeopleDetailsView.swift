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
                HStack(alignment: .center, spacing: 15) {
                    ImageViewModel(imageLoader: ImageLoaderViewModel(url: ImageAPI.Size.medium.path(poster: (viewModel.peopleDetail.profilePath ?? ""))), imageName: viewModel.peopleDetail.name)
                        .frame(width: 150, height: 240)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.7), radius: 20, x: 0, y: 10)
                        .padding(.leading, 20)
                    VStack {
                        Text(viewModel.peopleDetail.name)
                            .bold()
                        Text(DateFormattingHelper.shared.printFormattedDate(viewModel.peopleDetail.birthday, printFormat: "MMM dd,yyyy"))
                            .bold()
                    }
                }
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
