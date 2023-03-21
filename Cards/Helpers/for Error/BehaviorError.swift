//
//  BehaviorError.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Enumeration

enum BehaviorError {
    case failCastToFlippableView
    case failCastToBoardGameVC
    case failGettingViewModel
}

// MARK: - Extension

extension BehaviorError: Error, LocalizedError {
    var errorDescription: String? {
        switch self {
        case .failCastToFlippableView:
            return NSLocalizedString("Ошибка приведения типа к FlippableView", comment: "")
        case .failCastToBoardGameVC:
            return NSLocalizedString("Ошибка приведения типа к BoardGameVC", comment: "")
        case .failGettingViewModel:
            return NSLocalizedString("Не удалось получить viewModel", comment: "")
        }
    }
}
