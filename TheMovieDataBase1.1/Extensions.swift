//
//  Extensions.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 11/8/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation
import SwiftUI
import RealmSwift

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        //dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}

extension Date {
   func printFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension DateFormatter {
    static func dateConvertor(_ dateInput: String) -> Date {
        var dateOutput = Date()
        let dateFormattterGet = DateFormatter()
        dateFormattterGet.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormattterGet.date(from: dateInput) {
            dateOutput = date
        } else {
            let empty = DateFormatter()
            empty.dateFormat = "yyyy-MM-dd"
            dateOutput = empty.date(from: "1970-12-29")!
            print("There was an error converting date")
        }
        return dateOutput
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
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
    
    static func fecthImage(imageName: String) -> UIImage? {
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

