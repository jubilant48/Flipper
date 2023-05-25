//
//  AnimationService.swift
//  Cards
//
//  Created by macbook on 12.01.2023.
//

import UIKit

// MARK: - Class

final class AnimationService {
    // MARK: Methods
    
    static func removeCards(arrayOfCards cards: [UIView], compliteion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, delay: 0.2) {
            cards.first!.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            cards.last!.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        } completion: { _ in
            cards.first!.removeFromSuperview()
            cards.last!.removeFromSuperview()
            compliteion?()
        }
    }
    
    static func returnToStartTouchPoint(superview: UIView, subview: UIView, startPoint: CGPoint) {
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 1,
                       initialSpringVelocity: 2.2) {
            subview.frame.origin = startPoint
        }
        
        UIView.animate(withDuration: 0.4) {
            superview.layer.borderColor = UIColor.red.cgColor
        } completion: { _ in
            UIView.animate(withDuration: 0.4, delay: 0.5) {
                superview.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    static func setupCardsBordersAnimating(arrayOfCards cards: [UIView], color: UIColor) {
        UIView.animate(withDuration: 0.4) {
            for card in cards {
                card.layer.borderWidth = 3
                card.layer.borderColor = color.cgColor
            }
        }
    }
}
