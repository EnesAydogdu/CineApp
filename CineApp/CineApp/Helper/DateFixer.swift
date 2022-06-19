//
//  SeriesDateFormatter.swift
//  CineApp
//
//  Created by Enes Aydogdu on 20.05.2022.
//  Copyright © 2022 Enes Aydogdu. All rights reserved.
//

import Foundation

class DateFixer {
    
    
    static func getYear(enteredDate: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: enteredDate) else { return nil }
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        return year
    }
    
    static func dateConfig(enteredDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: enteredDate) else { return nil }
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
}
