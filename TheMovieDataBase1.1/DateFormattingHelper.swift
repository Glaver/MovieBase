//
//  DateFormattingHelper.swift
//  TheMovieDataBase1.1
//
//  Created by Vladyslav on 24/10/20.
//  Copyright © 2020 Vladyslav Gubanov. All rights reserved.
//

import Foundation

private protocol DateFormatterType {
    func string(from date: Date) -> String
}

class DateFormattingHelper {

    static let shared = DateFormattingHelper()

    let yearMonthDayDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    func printFormattedDate(_ date: Date, printFormat: String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = printFormat
        return dateFormat.string(from: date)
    }
}

extension DateFormatter: DateFormatterType { }

class CachedDateFormattingHelper {
    static let shared = CachedDateFormattingHelper()

    let cachedDateFormattersQueue = DispatchQueue(label: "com.boles.date.formatter.queue")

    private var cachedDateFormatters = [String: DateFormatterType]()

    private func cachedDateFormatter(withFormat format: String) -> DateFormatterType {
        return cachedDateFormattersQueue.sync {
            let key = format
            if let cachedFormatter = cachedDateFormatters[key] {
                return cachedFormatter
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format

            cachedDateFormatters[key] = dateFormatter

            return dateFormatter
        }
    }
}
