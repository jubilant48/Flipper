//
//  FlippableView.swift
//  Cards
//
//  Created by macbook on 06.01.2023.
//

import UIKit

// MARK: - Protocol

protocol FlippableCard: FlippableView {
    // MARK: - Properties
    
    var backSideType: CardBackSide! { get set }
    
    // MARK: - Methods
        
    func cleanFlip()
}
