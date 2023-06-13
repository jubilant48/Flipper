//
//  CommonError.swift
//  Cards
//
//  Created by macbook on 13.06.2023.
//

import UIKit

// MARK: - Enumeration

enum CommonError {
    case unwrapFailed(file: String, line: Int)
    case conversationFiled(file: String, line: Int)
    case creationFailed(file: String, line: Int)
    case complexUnwrapAndConversation(file: String, line: Int)
    case dataNotFound(file: String, line: Int)
}

// MARK: - Extension

extension CommonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unwrapFailed(let file, let line):
            return NSLocalizedString("Ошибка развертывания типа в файле \(file) на \(line) строке", comment: "")
        case .conversationFiled(let file,let line):
            return NSLocalizedString("Ошибка преобразования типа в файле \(file) на \(line) строке", comment: "")
        case .creationFailed(let file,let line):
            return NSLocalizedString("Ошибка создания типа в файле \(file) на \(line) строке", comment: "")
        case .complexUnwrapAndConversation(let file, let line):
            return NSLocalizedString("Комплексная ошибка:\nPазвертывания и/или преобразования типа в файле \(file) на \(line) строке", comment: "")
        case .dataNotFound(let file,let line):
            return NSLocalizedString("Данные не найдены.\nФайл: \(file)\nСтрока: \(line)", comment: "")
        }
    }
}
