//
//  CardViewModelView.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

final class CardViewModelView: CardViewViewModelType {
    // MARK: - Properties
    
    var startTouchPoint: CGPoint = CGPoint(x: 0, y: 0)
    var firstTouch: CGPoint = CGPoint(x: 0, y: 0)
    
    var flipBehavior: FlipBehavior = CardFlipBehavior()
    var touchesBehavior: TouchesBehavior = CardTouchesBehavior()
    var climbBehavior: ClimbBehavior = ClimbInBehavior()
    
}


