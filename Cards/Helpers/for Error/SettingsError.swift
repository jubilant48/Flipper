//
//  SettingsError.swift
//  Cards
//
//  Created by macbook on 21.01.2023.
//

import UIKit

// MARK: - Enumeration

enum SettingsError {
    case dataNotExist
    case unwrapFailed
}

// MARK: - Extension

extension SettingsError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataNotExist:
            return NSLocalizedString("Отсутствуют настройки в файлах приложения", comment: "")
        case .unwrapFailed:
            return NSLocalizedString("Ошибка развертывания данных", comment: "")
        }
    }
}

