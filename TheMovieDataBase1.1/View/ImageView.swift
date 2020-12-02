//
//  ImageModelView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 31/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoaderService
    @State private var isAnimating = false
    var imagePath: String? = ""
    var imageCache: ImageLoaderCache

    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: imageCache.downloadAndStore(path: imagePath, loadedImage: imageLoader.image!)!)
                    .resizable()
                    .renderingMode(.original)
            } else if imagePath == nil {
                ZStack {
                    Image("blur")
                        .resizable()
                        .renderingMode(.original)
                    Image(systemName: "nosign")
                        .resizable()
                        .frame(width: 50, height: 50, alignment: .center)
                }
            } else {
                Image("blur")
                    .resizable()
                    .renderingMode(.original)
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
        }
    }
}
