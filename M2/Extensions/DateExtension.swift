//
//  DateExtension.swift
//  M2
//
//  Created by Petrov Anton on 11/19/19.
//  Copyright © 2019 APM. All rights reserved.
//

import Foundation

extension Date {
    
    func addMonth(_ n: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .month, value: n, to: self)!
    }
    
    func addDay(_ n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .day, value: n, to: self)!
    }
    func addSec(_ n: Int) -> Date {
        let cal = NSCalendar.current
        return cal.date(byAdding: .second, value: n, to: self)!
    }
}

extension Date {
  
  private static var dateFormater: DateFormatter = {
    return DateFormatter()
  }()
  
  func stringDate(format: String) -> String {
    Date.dateFormater.dateFormat = format
    return Date.dateFormater.string(from: self)
  }
}

