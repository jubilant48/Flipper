//
//  ContinueProtocol + Extension.swift
//  Cards
//
//  Created by macbook on 27.02.2023.
//

import UIKit

// MARK: - Extension

extension ContinueProtocol {
    // MARK: - Methods
    
    private func setupViewData(card: Card, cardData: CardData) throws {
        guard let setViews = cardData.views as? NSMutableOrderedSet else { return }
        
        try setViews.forEach { view in
            if let viewData = view as? ViewData {
                guard let backTypeString = viewData.backSideType,
                      let back = CardBackSide(rawValue: backTypeString) else { throw ContinueError.backCardNotExist }
                
                let point = CGPoint(x: CGFloat(viewData.x), y: CGFloat(viewData.y))
        
                let viewInfo = ViewInfo(back: back, isFlipped: viewData.isFlipped, point: point)
                
                card.viewData.append(viewInfo)
            }
        }
    }
    
    func setGameDataFor(_ boardGameController: BoardGameVC, gameData: GameData) throws {
        
        let game = Game()
        game.cardsCount = Int(gameData.cardsCount)
        game.numberOfCardFlips = Int(gameData.numberOfCardFlips)
        
        boardGameController.viewModel.game = game
        boardGameController.viewModel.countTouchesOnCard = Int(gameData.countTouchesOnCard)
        boardGameController.viewModel.timerService.setSecond(Int(gameData.second))
        
        guard let setCard = gameData.cards as? NSMutableOrderedSet else { return }
        
        try setCard.forEach { card in
            if let cardData = card as? CardData {
                guard let cardTypeString = cardData.cardType,
                      let type = CardType(rawValue: cardTypeString) else {
                    throw ContinueError.cardTypeNotExist
                }
                
                guard let cardColorString = cardData.cardColor,
                      let color = CardColor(rawValue: cardColorString) else {
                    throw ContinueError.cardColorNotExist
                }
                
                let card = Card(type: type, color: color)
                
                do {
                    try setupViewData(card: card, cardData: cardData)
                } catch {
                    throw error
                }
                
                boardGameController.viewModel.game.allExistingCards.append(card)
            }
        }
    }
}
