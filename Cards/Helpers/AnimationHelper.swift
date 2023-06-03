//
//  AnimationHelper.swift
//  Cards
//
//  Created by macbook on 12.01.2023.
//

import UIKit

// MARK: - Class

final class AnimationHelper {
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
    
    static func animationOn(timerButton: TimerButton) {
        UIView.animate(withDuration: 0.5) {
            timerButton.layer.borderColor = UIColor.clear.cgColor
            timerButton.layer.borderWidth = 0
            timerButton.hiddenLabel.layer.opacity = 0
            timerButton.setTitleColor(.getBlue(), for: .normal)
            timerButton.titleLabel?.transform = .identity
        }
    }
    
    static func animationOff(timerButton: TimerButton) {
        UIView.animate(withDuration: 0.5) {
            timerButton.layer.borderColor = UIColor.getRed().cgColor
            timerButton.layer.borderWidth = 3
            timerButton.hiddenLabel.layer.opacity = 1.0
            timerButton.setTitleColor(.getRed(), for: .normal)
            timerButton.titleLabel?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).translatedBy(x: 0, y: 20)
        }
    }
    
    static func flip(_ boardView: BoardGameView) {
        UIView.animate(withDuration: 0.5) {
            boardView.flip()
        }
    }
}
