//
//  ImageModelView.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 31/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageViewModel: View {
    @ObservedObject var imageLoader: ImageLoaderViewModel
    @State private var isAnimating = false
    var imageName: String

    var body: some View {
        ZStack {
            if self.downloadAndStore(imageName: imageName) != nil {
                Image(uiImage: self.downloadAndStore(imageName: imageName)!)
                    .resizable()
                    .renderingMode(.original)
            } else {
                Image("blur")
                    .resizable()
                    .renderingMode(.original)
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            }
        }
    }

    func downloadAndStore(imageName: String) -> UIImage? {
        if let loader = FileManager.fetchImage(imageName: imageName) {
            //print("upload from file manager \(imageName)")
            return loader
        } else {
            var imageOutput: UIImage?
            if let loaders = imageLoader.image {
                imageOutput = loaders
                try? FileManager.saveImage(image: loaders, imageName: imageName)
            }
            return imageOutput
        }
    }
}
