//
//  SectionView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 6/11/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import SwiftUI

struct SectionView: View {
    var section: MovieShowViewProtocol
    let inputURLforImage: URL?
    let genresDictionary: GenresDictionaryProtocol
    var body: some View {
        HStack {
            ImageViewModel(imageLoader: ImageLoaderViewModel(url: inputURLforImage), imageName: section.posterFileManagerName)
                .frame(width: 130, height: 195, alignment: .top)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(5)
                .shadow(color: Color.blue.opacity(0.5), radius: 20, x: 0, y: 10)

            VStack(alignment: .leading) {
                Text(section.title)
                    .font(.system(size: 15))
                    .bold()
                    .frame(width: 190, height: 70, alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)

                VStack(alignment: .leading) {
                    HStack {
                        ForEach(Mappers.convertorGenresToString(genresDict: genresDictionary, genresOfMovie: section.genres).prefix(2), id: \.self) { genre in
                            Text(genre.capitalizingFirstLetter())
                                .lineLimit(1)
                                .font(.system(size: 13))
                                .padding(4)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(5)
                        }
                    }
                    HStack {
                        ForEach(Mappers.convertorGenresToString(genresDict: genresDictionary, genresOfMovie: section.genres).dropFirst(2), id: \.self) { genre in
                            Text(genre.capitalizingFirstLetter())
                                .lineLimit(1)
                                .font(.system(size: 13))
                                .padding(4)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(5)
                        }

                    }
                }.padding(5)
                Spacer()
                HStack {
                    Text(DateFormattingHelper.shared.printFormattedDate(section.releaseDate, printFormat: "MMM dd,yyyy"))
                        .foregroundColor(Color.blue)
                    Spacer()
                    if section.voteAverage != 0 {
                    Text(String(section.voteAverage))
                        .font(Font.body.bold())
                        .foregroundColor(.black)
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
            }
        }
    }
}
