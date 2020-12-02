//
//  ImageLoaderCache.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 2/12/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//
import SwiftUI
import Foundation
import UIKit
import Combine

class ImageLoaderCache {
    static let shared = ImageLoaderCache()
    var imageCache = NSCache<NSString, UIImage>()
    func downloadAndStore(path: String?, loadedImage: UIImage) -> UIImage? {
        let key = NSString(string: "\(path ?? "miss")" )
        if let loader = imageCache.object(forKey: key) {
            //print("upload from file Cache \(path ?? "miss")")
            return loader
        } else {
            let loaders = loadedImage
            imageCache.setObject(loaders, forKey: key)
            //print("save file  \(path ?? "miss")")
            return loaders
        }
    }
}
