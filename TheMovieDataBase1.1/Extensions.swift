//
//  Extensions.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 11/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter {$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

extension FileManager {

    enum SavingImageError: Error {
        case incomeDataNotImage
        case directoryFail
    }

    static func saveImage(image: UIImage, imageName: String) throws {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            throw SavingImageError.incomeDataNotImage }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            throw SavingImageError.directoryFail }
        do {
            try data.write(to: directory.appendingPathComponent(imageName + ".png")!)
        } catch {
            print(error.localizedDescription)
        }
    }

    static func fetchImage(imageName: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(imageName).path)
        }
        return nil
    }

    static func clearAllFile() {
        let fileManager = FileManager.default
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print("Directory: \(paths)")

        do {
            let fileName = try fileManager.contentsOfDirectory(atPath: paths)
            for file in fileName {
                // For each file in the directory, create full path and delete the file
                let filePath = URL(fileURLWithPath: paths).appendingPathComponent(file).absoluteURL
                try fileManager.removeItem(at: filePath)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

extension URL {
    init(staticString string: StaticString) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }

        self = url
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Collection {

    // Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
/*
 static func saveImage(image: UIImage, imageName: String) -> Bool {
 guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return false }
 guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else { return false }
 do {
 try data.write(to: directory.appendingPathComponent(imageName + ".png")!)
 return true
 } catch {
 print(error.localizedDescription)
 return false
 }
 }
 */
