//
//  Date+Extension.swift
//  Shabbat Pro
//
//  Created by Idan Moshe on 29/07/2020.
//  Copyright © 2020 Idan Moshe. All rights reserved.
//

import Foundation

extension Date {
    
    var hebrewMonthName: String {
        let formatter: DateFormatter = .israelHebrewDateFormatter
        formatter.dateFormat = "LLLL"
        return formatter.string(from: self)
    }
    
    static var allYear: [Date] {
        var year: [Date] = []
        
        let currentYear = Calendar(identifier: .gregorian).component(.year, from: Date())
        
        // Start from 'Thishrei'
        for i in 10..<12 {
            if let date = Date.generate(minute: 1, hour: 1, day: 1, month: i, year: currentYear) {
                year.append(date)
            }
        }
        
        // Append the rest of the Hebrew year
        for i in 0..<10 {
            if let date = Date.generate(minute: 1, hour: 1, day: 1, month: i, year: currentYear) {
                year.append(date)
            }
        }
        
        return year
    }
    
    static var localizedMonths: [String] {
        var months: [String] = []
        let year: [Date] = Date.allYear
        for date in year {
            months.append(date.hebrewMonthName)
        }
        return months
    }
    
    static var localizedCurrentMonth: String {
        return Date().hebrewMonthName
    }
    
    static func generate(timeZone: TimeZone = .current, calendar: Calendar = .current, minute: Int, hour: Int, day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = timeZone
        dateComponents.hour = hour
        dateComponents.minute = minute
        return calendar.date(from: dateComponents) ?? nil
    }
    
}

extension TimeZone {
    static var israelTimeZone: TimeZone {
        return TimeZone(identifier: "Asia/Jerusalem")!
    }
}

extension Calendar {
    static var hebrewCalendar: Calendar {
        return Calendar(identifier: .hebrew)
    }
}

extension DateFormatter {
    
    static var israelHebrewDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = .hebrewCalendar
        formatter.timeZone = .israelTimeZone
        formatter.locale = .hebrewLocale
        return formatter
    }
    
    static var serverDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }
    
}

extension Locale {
    static var hebrewLocale: Locale {
        return Locale(identifier: "he-IL")
    }
}
