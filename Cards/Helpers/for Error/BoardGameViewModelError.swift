//
//  BoardGameViewModelError.swift
//  Cards
//
//  Created by macbook on 07.03.2023.
//

import UIKit

// MARK: - Enumerations

enum BoardGameViewModelError {
    case conversationError
}

// MARK: - Extension

extension BoardGameViewModelError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .conversationError:
            return NSLocalizedString("Ошибка преобразования!", comment: "")
        }
    }
}
