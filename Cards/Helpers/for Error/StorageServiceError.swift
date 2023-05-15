//
//  StorageServiceError.swift
//  Cards
//
//  Created by macbook on 30.01.2023.
//

import UIKit

// MARK: - Enumerations

enum StorageServiceError {
    case entityNotFound
    case missingCardSet
    case missingPointSet
    case failed(type: String)
}

// MARK: - Extension

extension StorageServiceError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .entityNotFound:
            return NSLocalizedString("Не удалось найти модель данных", comment: "")
        case .missingCardSet:
            return NSLocalizedString("Не удалось получить множество cardData", comment: "")
        case .missingPointSet:
            return NSLocalizedString("Не удалось получить множество views", comment: "")
        case .failed(let type):
            return NSLocalizedString("Неудачное приведеие типа \(type)", comment: "")
        }
    }
}
