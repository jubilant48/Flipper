//
//  SettingsProtocol.swift
//  Cards
//
//  Created by macbook on 17.01.2023.
//

import UIKit

protocol SettingsProtocol {
    // MARK: - Properties
    
    var numberPairsCards: Int { get set }
    var isShowReverseCardsButton: Bool { get set }
    var cardTypes: Set<String> { get set }
    var cardColors: Set<String> { get set }
    var cardBackSides: Set<String> { get set }
    
    // MARK: - Methods
    
    func getCardTypes() -> [CardType]
    func getCardColors() -> [CardColor]
    func getCardBackSides() -> [CardBackSide]
}
