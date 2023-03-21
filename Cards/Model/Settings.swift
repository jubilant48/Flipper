//
//  Settings.swift
//  Cards
//
//  Created by macbook on 17.01.2023.
//

import UIKit

// MARK: - Class

final class Settings: Codable, SettingsProtocol {
    // MARK: Properties
    
    static let shared = Settings()
    
    static let documentDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL: URL = documentDirectory.appendingPathComponent("Settings").appendingPathExtension("plist")
    
    var numberPairsCards: Int = 8
    var isShowReverseCardsButton: Bool = true
    var cardTypes: Set<String> = [CardType.circle.rawValue, CardType.cross.rawValue, CardType.square.rawValue, CardType.fill.rawValue]
    var cardColors: Set<String> = [CardColor.red.rawValue, CardColor.green.rawValue, CardColor.black.rawValue, CardColor.gray.rawValue, CardColor.brown.rawValue, CardColor.yellow.rawValue, CardColor.purple.rawValue, CardColor.orange.rawValue, CardColor.white.rawValue]
    var cardBackSides: Set<String> = [CardBackSide.circle.rawValue, CardBackSide.line.rawValue]
    
    // MARK: Methods
    
    func getCardTypes() -> [CardType] {
        var types = [CardType]()
        
        for value in cardTypes {
            guard let type = CardType(rawValue: value) else {
                fatalError("Не получилось создать тип фигуры карты")
            }
            
            types.append(type)
        }
        
        return types
    }
    
    func getCardColors() -> [CardColor] {
        var colors = [CardColor]()
        
        for value in cardColors {
            guard let color = CardColor(rawValue: value) else {
                fatalError("Не получилось создать цвет фигуры")
            }
            
            colors.append(color)
        }
        
        return colors
    }
    
    func getCardBackSides() -> [CardBackSide] {
        var backSides = [CardBackSide]()
        
        for value in cardBackSides {
            guard let backSide = CardBackSide(rawValue: value) else {
                fatalError("Не получилось создать рубашку карты")
            }
            
            backSides.append(backSide)
        }
        
        return backSides
    }
}

// MARK: - Settings storage protocol

extension Settings: SettinsStorageProtocol {
    private func setup(_ settings: Settings) {
        Settings.shared.numberPairsCards = settings.numberPairsCards
        Settings.shared.isShowReverseCardsButton = settings.isShowReverseCardsButton
        Settings.shared.cardTypes = settings.cardTypes
        Settings.shared.cardColors = settings.cardColors
        Settings.shared.cardBackSides = settings.cardBackSides
    }
    
    func loadSettings() throws {
        guard let codedSettings = try? Data(contentsOf: Settings.archiveURL) else { throw SettingsError.dataNotExist }
        
        let propertyListDecoder = PropertyListDecoder()
        let settings = try? propertyListDecoder.decode(Settings.self, from: codedSettings)
        
        guard let settings = settings else { throw SettingsError.unwrapFailed }
        
        setup(settings)
    }
    
    func saveSettings() {
        let propertyListEncoder = PropertyListEncoder()
        
        let codedSettings = try? propertyListEncoder.encode(Settings.shared)
        
        try? codedSettings?.write(to: Settings.archiveURL, options: .noFileProtection)
    }
}
