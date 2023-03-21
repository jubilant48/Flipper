//
//  LabelAndSwitchViewModelCell.swift
//  Cards
//
//  Created by macbook on 17.02.2023.
//

import UIKit

final class LabelAndSwitchViewModelCell: LabelAndSwitchCellViewModelType {
    // MARK: - Enumeration
    
    enum NameSpaces: String {
        case title = "Режим просмотра карт"
    }
    
    // MARK: - Properties
    
    private var settings: Settings = Settings.shared
    
    var title: String {
        return NameSpaces.title.rawValue
    }
    var isOn: Bool {
        return settings.isShowReverseCardsButton
    }
}
