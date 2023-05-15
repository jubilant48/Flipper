//
//  RecordTVViewModelCell.swift
//  Cards
//
//  Created by macbook on 15.05.2023.
//

import UIKit

final class RecordTVViewModelCell: RecordTableViewCellViewModelType {
    // MARK: - Enumeration
    
    enum RecordNameSpaces: String {
        case firstPlaceMedal = "🥇"
        case secondPlaceMedal = "🥈"
        case thirdPlaceMedal = "🥉"
        
        static func medal(for place: Int) -> String? {
            switch place {
            case 1:
                return RecordNameSpaces.firstPlaceMedal.rawValue
            case 2:
                return RecordNameSpaces.secondPlaceMedal.rawValue
            case 3:
                return RecordNameSpaces.thirdPlaceMedal.rawValue
            default:
                return nil
            }
        }
    }
    
    // MARK: - Properties
    
    var place: String
    var time: String
    var date: String
    var score: String
    
    // MARK: - Init
    
    init(place: Int, time: Int, date: Date, score: Int) {
        if let place = RecordNameSpaces.medal(for: place)  {
            self.place = place
        } else {
            self.place = String(place) 
        }
        
        self.time = TimeFormatter.timeFormatted(time)
        self.date = TimeFormatter.timeFormattedForRecordCell(date)
        self.score = String(score)
    }
}
