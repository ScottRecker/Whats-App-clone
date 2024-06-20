//
//  Date+Extension.swift
//  Whats App Clone
//
//  Created by Scott Recker on 6/19/24.
//

import Foundation

extension Date {
    /// if today: 3:30 PM
    /// if yesterday returns Yesterday
    /// 02/14/24
    var dayOrTimeRepresentation: String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()

        if calendar.isDateInToday(self) {
            dateFormatter.dateFormat = "h:mm a"
            let formattedDate = dateFormatter.string(from: self)
            return formattedDate
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: self)
        }
    }

    /// 3:30 pm
    var formattedToTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let formattedTime = dateFormatter.string(from: self)
        return formattedTime


    }
}
