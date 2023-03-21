//
//  CardViewViewModelType.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Protocol

protocol CardViewViewModelType {
    // MARK: - Properties
    
    var startTouchPoint: CGPoint { get set }
    var firstTouch: CGPoint { get set }
    
    var flipBehavior: FlipBehavior { get }
    var touchesBehavior: TouchesBehavior { get }
    var climbBehavior: ClimbBehavior { get }
}
