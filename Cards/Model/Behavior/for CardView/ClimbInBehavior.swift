//
//  ClimbInBehavior.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Class

final class ClimbInBehavior: ClimbBehavior {
    // MARK: Methods
    
    func climb(startPoint: CGPoint, view: UIView) {
        climbInBounds(startPoint: startPoint, view: view)
    }
    
    private func climbInBounds(startPoint: CGPoint, view: UIView) {
        guard let superview = view.superview else {
            print("Loss a superview")
            return
        }
        
        let borderWidthLimitCards = (0...(superview.bounds.width - view.bounds.width))
        let borderHeightLimitCards = (0...(superview.bounds.height - view.bounds.height))
        
        if !borderWidthLimitCards.contains(view.frame.origin.x) || !borderHeightLimitCards.contains(view.frame.origin.y) {
            do {
                try SoundService.play(sound: .pushToLimits)
            } catch {
                view.parentViewController?.showErrorAlert(description: error.localizedDescription)
            }
            
            AnimationService.returnToStartTouchPoint(superview: superview, subview: view, startPoint: startPoint)
        }
    }
}
