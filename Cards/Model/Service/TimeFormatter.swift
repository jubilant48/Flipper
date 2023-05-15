//
//  TimeFormatter.swift
//  Cards
//
//  Created by macbook on 15.05.2023.
//

import UIKit

// MARK: - Class

final class TimeFormatter {
    // MARK: - Methods
    
    static func timeFormatted(_ totalSeconds: Int) -> String {
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            return String(format: "%02d:%02d", minutes, seconds)
    }
    
    static func timeFormattedForRecordCell(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd.MM.yyyy 'в' HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
