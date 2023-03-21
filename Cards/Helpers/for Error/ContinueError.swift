//
//  ContinueError.swift
//  Cards
//
//  Created by macbook on 27.02.2023.
//

import UIKit

// MARK: - Enumeration

enum ContinueError {
    case backCardNotExist
    case cardTypeNotExist
    case cardColorNotExist
}

// MARK: - Extension

extension ContinueError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .backCardNotExist:
            return NSLocalizedString("Не удалось получить back card карты!", comment: "")
        case .cardTypeNotExist:
            return NSLocalizedString("Не удалось получить type карты!", comment: "")
        case .cardColorNotExist:
            return NSLocalizedString("Не удалось получить color карты!", comment: "")
        }
    }
}
