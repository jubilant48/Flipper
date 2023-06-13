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
    
    func beforeFlip(_ view: UIView) throws {
        view.superview?.bringSubviewToFront(view)
        
        try SoundService.play(sound: .flip)
    }
    
    private func getCardAndVC(_ view: UIView) throws -> (FlippableCard, BoardGameVC, BoardGameViewViewModelType) {
        guard let card = view as? FlippableCard else {
            throw CommonError.conversationFiled(file: #fileID, line: #line)
        }
        
        guard let boardGameVC = view.parentViewController as? BoardGameVC else {
            throw CommonError.complexUnwrapAndConversation(file: #fileID, line: #line)
        }
        
        guard let viewModel = boardGameVC.viewModel else {
            throw CommonError.dataNotFound(file: #fileID, line: #line)
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
                
                do {
                    
                    try viewModel.checkCards(firstCard: firstCard, secondCard: secondCard, completion: boardGameVC.resetTouchesOnCard)
                } catch {
                    boardGameVC.parentViewController?.showErrorAlert(description: error.localizedDescription)
                }
            }
            
        } catch {
            throw error
        }
    }
}
