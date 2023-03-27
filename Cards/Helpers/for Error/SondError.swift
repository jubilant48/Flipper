//
//  SondError.swift
//  Cards
//
//  Created by macbook on 27.03.2023.
//

import UIKit

// MARK: - Enumeration

enum SoundError {
    case sondNotFound
}

// MARK: - Extension

extension SoundError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .sondNotFound:
            return NSLocalizedString("Не удалось получить трек", comment: "")
        }
    }
}
