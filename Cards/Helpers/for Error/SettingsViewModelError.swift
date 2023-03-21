//
//  SettingsViewModelError.swift
//  Cards
//
//  Created by macbook on 17.02.2023.
//

import UIKit

// MARK: - Enumeration

enum SettingsViewModelError {
    case sectionNotExist
}

// MARK: - Extension

extension SettingsViewModelError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .sectionNotExist:
            return NSLocalizedString("Не удалось получить кол-во секций", comment: "")
        }
    }
}
