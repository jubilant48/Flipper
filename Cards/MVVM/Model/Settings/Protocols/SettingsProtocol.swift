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
    var animationBoardGameView: String { get set }
    
    // MARK: - Methods
    
    func getCardTypes() throws -> [CardType]
    func getCardColors() throws -> [CardColor]
    func getCardBackSides() throws -> [CardBackSide]
    func getBoardAnimation() throws -> AnimationHelper.Animation
}
