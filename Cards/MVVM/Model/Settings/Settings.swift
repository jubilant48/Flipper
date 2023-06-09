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
    var animationBoardGameView: String = AnimationHelper.Animation.swingInUFO.rawValue
    
    // MARK: Methods
    
    func getCardTypes() throws -> [CardType] {
        var types = [CardType]()

        for value in cardTypes {
            guard let type = CardType(rawValue: value) else {
                throw CommonError.creationFailed(file: #fileID, line: #line)
            }
            
            types.append(type)
        }
        
        return types
    }
    
    func getCardColors() throws -> [CardColor] {
        var colors = [CardColor]()
        
        for value in cardColors {
            guard let color = CardColor(rawValue: value) else {
                throw CommonError.creationFailed(file: #fileID, line: #line)
            }
            
            colors.append(color)
        }
        
        return colors
    }
    
    func getCardBackSides() throws -> [CardBackSide] {
        var backSides = [CardBackSide]()
        
        for value in cardBackSides {
            guard let backSide = CardBackSide(rawValue: value) else {
                throw CommonError.creationFailed(file: #fileID, line: #line)
            }
            
            backSides.append(backSide)
        }
        
        return backSides
    }
    
    func getBoardAnimation() throws -> AnimationHelper.Animation {
        guard let animation = AnimationHelper.Animation(rawValue: animationBoardGameView) else {
            throw CommonError.creationFailed(file: #fileID, line: #line)
        }
        
        return animation
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
        Settings.shared.animationBoardGameView = settings.animationBoardGameView
    }
    
    func loadSettings() throws {
        guard let codedSettings = try? Data(contentsOf: Settings.archiveURL) else { throw CommonError.dataNotFound(file: #fileID, line: #line) }
        
        let propertyListDecoder = PropertyListDecoder()
        let settings = try? propertyListDecoder.decode(Settings.self, from: codedSettings)
        
        guard let settings = settings else { throw CommonError.unwrapFailed(file: #fileID, line: #line) }
        
        setup(settings)
    }
    
    func saveSettings() {
        let propertyListEncoder = PropertyListEncoder()
        
        let codedSettings = try? propertyListEncoder.encode(Settings.shared)
        
        try? codedSettings?.write(to: Settings.archiveURL, options: .noFileProtection)
    }
}
