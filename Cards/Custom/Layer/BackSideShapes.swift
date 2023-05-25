//
//  BackSideShapes.swift
//  Cards
//
//  Created by macbook on 06.01.2023.
//

import UIKit

// MARK: - BackSideCircle

final class BackSideCircle: CAShapeLayer, ShapeLayerProtocol {
    // MARK: Init
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        
        for _ in 1...15 {
            let randomX = Int.random(in: 0...Int(size.width))
            let randomY = Int.random(in: 0...Int(size.height))
            let center = CGPoint(x: randomX, y: randomY)
            
            path.move(to: center)
            
            let radius = Int.random(in: 5...15)
            
            path.addArc(withCenter: center, radius: CGFloat(radius), startAngle: 0, endAngle: .pi * 2, clockwise: true)
        }
        
        self.path = path.cgPath
        
        self.strokeColor = fillColor
        self.fillColor = fillColor
        self.lineWidth = 1
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - BackSideLine

final class BackSideLine: CAShapeLayer, ShapeLayerProtocol {
    // MARK: Init
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath()
        
        for _ in 1...15 {
            let randomXStart = Int.random(in: 0...Int(size.width))
            let randomYStart = Int.random(in: 0...Int(size.height))
            
            let randomXEnd = Int.random(in: 0...Int(size.width))
            let randomYEnd = Int.random(in: 0...Int(size.height))
            
            path.move(to: CGPoint(x: randomXStart, y: randomYStart))
            
            path.addLine(to: CGPoint(x: randomXEnd, y: randomYEnd))
        }
        
        self.path = path.cgPath
        
        self.strokeColor = fillColor
        self.lineWidth = 3
        self.lineCap = .round
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
