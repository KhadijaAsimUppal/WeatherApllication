//
//  Extensions.swift
//  Weather Application
//
//  Created by Khadija Asim on 20/07/2020.
//  Copyright © 2020 Tintash. All rights reserved.
//

import Foundation

extension Date {
/// Returns string for date without time components in formate *YYYY-MM-dd*
    func dateStringWithoutTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }
/// Returns string for time without date components in formate *h:mm a*
    func timeStringWithoutDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }

    func elaboratedDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
        return dateFormatter.string(from: self)
    }

}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if (!result.contains(value)) {
                result.append(value)
            }
        }
        return result
    }
}

extension Double {
    func toString(withFormat format: String = "%.f") -> String {
        return String(format:format,self)
    }

    func convertToCelcius() -> Double {
        return (self - 273.15)
    }
}

extension Int {
    func toString(withFormat format: String = "%.f") -> String {
        return String(format:format,self)
    }

}


