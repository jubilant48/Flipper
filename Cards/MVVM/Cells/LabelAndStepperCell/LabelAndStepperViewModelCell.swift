//
//  LabelAndStepperViewModelCell.swift
//  Cards
//
//  Created by macbook on 17.02.2023.
//

import UIKit

final class LabelAndStepperViewModelCell: LabelAndStepperCellViewModelType {
    // MARK: - Enumeration
    
    enum NameSpaces: String {
        case title = "Количество пар-карт"
    }
    
    // MARK: - Properties
    
    private let settings: Settings = Settings.shared
    
    var title: String {
        return NameSpaces.title.rawValue
    }
    var currentValue: Int {
        return settings.numberPairsCards
    }
}
