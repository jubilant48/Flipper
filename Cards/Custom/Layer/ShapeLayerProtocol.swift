//
//  ShapeLayerProtocol.swift
//  Cards
//
//  Created by macbook on 06.01.2023.
//

import UIKit

// MARK: - Protocol

protocol ShapeLayerProtocol: CAShapeLayer {
    // MARK: - Init
    
    init(size: CGSize, fillColor: CGColor)
}

// MARK: - Extension

extension ShapeLayerProtocol {
    init() {
        fatalError("init() не может быть использован для создания экземпляра")
    }
}
