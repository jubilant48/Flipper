//
//  CardTouchesBehavior.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Class

final class CardTouchesBehavior: TouchesBehavior {
    // MARK: Properties
    
    private var isStartPoint: Bool!
    private var isFlipped: Bool!
    
    // MARK: Methods
    
    func set(isStartPoint: Bool, isFlipped: Bool) {
        self.isStartPoint = isStartPoint
        self.isFlipped = isFlipped
    }
    
    private func getBoardGameVC(_ view: UIView) throws -> BoardGameVC {
        guard let boardGameVC = view.parentViewController as? BoardGameVC else {
            throw CommonError.complexUnwrapAndConversation(file: #fileID, line: #line)
        }
        
        return boardGameVC
    }
    
    func touchesBegan(_ view: UIView) {
        view.superview?.isUserInteractionEnabled = false
    }
    
    func touchesMoved(_ view: UIView) { }
    
    func touchesEnded(_ view: UIView) throws {
        view.superview?.isUserInteractionEnabled = true
        
        do {
            let boardGameVC = try getBoardGameVC(view)
            
            if isStartPoint {
                if isFlipped {
                    boardGameVC.viewModel.countTouchesOnCard += 1
                } else {
                    boardGameVC.viewModel.countTouchesOnCard -= 1
                }
            }
            
            if boardGameVC.viewModel.countTouchesOnCard == 2 {
                view.superview?.isUserInteractionEnabled = false
                boardGameVC.dismissButton.isEnabled = false
            }
        } catch {
            throw error
        }
    }
    
}
