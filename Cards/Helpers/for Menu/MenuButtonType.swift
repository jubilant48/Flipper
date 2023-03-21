//
//  MenuButtonType.swift
//  Cards
//
//  Created by macbook on 27.02.2023.
//

import UIKit

// MARK: - Enumeration

enum MenuButtonType {
    case continueType
    case start
    case settings
    case record
    case exit
    
    var name: String {
        switch self {
        case .continueType:
            return NameSpaces.continueTitle.rawValue
        case .start:
            return NameSpaces.startNewGameTitle.rawValue
        case .settings:
            return NameSpaces.settingsTitle.rawValue
        case .record:
            return NameSpaces.recordTitle.rawValue
        case .exit:
            return NameSpaces.exitTitle.rawValue
        }
    }
}
