//
//  FlipBehavior.swift
//  Cards
//
//  Created by macbook on 15.03.2023.
//

import UIKit

// MARK: - Protocol

protocol FlipBehavior {
    // MARK: - Methods
    
    func beforeFlip(_ view: UIView)
    func inFlipping(_ view: UIView) throws
}
