//
//  Date+Ago.swift
//  AppStore
//
//  Created by Yahaya on 07/07/2023.
//

import Foundation
extension Date {
    var timeAgo: String {
        get {
            let relativeDateFormatter = RelativeDateTimeFormatter()
            //change these to get different formats
            relativeDateFormatter.dateTimeStyle = .named
            relativeDateFormatter.unitsStyle = .full
            //you can know your loacal identifier here https://gist.github.com/jacobbubu/1836273
            relativeDateFormatter.locale = Locale(identifier: "ar_EG")
            let relativeDate = relativeDateFormatter.localizedString(for: self, relativeTo: Date())
            return relativeDate.capitalized
        }
    }
}
