//
//  CardFlipBehavior.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Class

final class CardFlipBehavior: FlipBehavior {
    // MARK: Properties
    
    let setting = Settings.shared
    
    // MARK: Methods
    
    func beforeFlip(_ view: UIView) {
        view.superview?.bringSubviewToFront(view)
    }
    
    private func getCardAndVC(_ view: UIView) throws -> (FlippableView, BoardGameVC, BoardGameViewViewModelType) {
        guard let card = view as? FlippableView else {
            throw BehaviorError.failCastToFlippableView
        }
        
        guard let boardGameVC = view.parentViewController as? BoardGameVC else {
            throw BehaviorError.failCastToBoardGameVC
        }
        
        guard let viewModel = boardGameVC.viewModel else {
            throw BehaviorError.failGettingViewModel
        }
        
        return (card, boardGameVC, viewModel)
    }
    
    func inFlipping(_ view: UIView) throws {
        do {
            var (card, boardGameVC, viewModel) = try getCardAndVC(view)
            
            if card.isFlipped {
                viewModel.flippedCards.append(card)
            } else {
                if let cardIndex = viewModel.flippedCards.firstIndex(of: card) {
                    viewModel.flippedCards.remove(at: cardIndex)
                }
            }
            
            if !setting.isShowReverseCardsButton {
                viewModel.game.increaseCountOfCardFlips()
                
                boardGameVC.buttonForNumberOfCardFlips.setTitle("\(viewModel.game.numberOfCardFlips)", for: .normal)
            }
            
            if boardGameVC.viewModel.flippedCards.count == 2 {
                let firstCard = viewModel.game.allExistingCards[viewModel.flippedCards.first!.tag]
                let secondCard = viewModel.game.allExistingCards[viewModel.flippedCards.last!.tag]
            
                viewModel.checkCards(firstCard: firstCard, secondCard: secondCard, completion: boardGameVC.resetTouchesOnCard)
            }
            
        } catch {
            throw error
        }
    }
}
