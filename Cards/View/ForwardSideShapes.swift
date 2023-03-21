//
//  Shapes.swift
//  Cards
//
//  Created by macbook on 20.12.2022.
//

import UIKit

// MARK: - FillShape

final class FillShape: CAShapeLayer, ShapeLayerProtocol {
    // MARK: Init
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        self.path = path.cgPath
        
        self.fillColor = fillColor
        
        if UIColor.white.cgColor == fillColor {
            self.strokeColor = UIColor.black.cgColor
        }
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CrossShape

final class CrossShape: CAShapeLayer, ShapeLayerProtocol {
    // MARK: Init
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let fillColor = UIColor.white.cgColor == fillColor ? UIColor.getMercuryColor()  .cgColor : fillColor
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.move(to: CGPoint(x: size.width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        
        self.path = path.cgPath
        
        self.strokeColor = fillColor
        self.lineWidth = 5
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CircleShape

final class CircleShape: CAShapeLayer, ShapeLayerProtocol {
    // MARK: Init
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let radius = ([size.width, size.height].min() ?? 0) / 2
        
        let centerX = size.width / 2
        let centerY = size.height / 2
        
        let path = UIBezierPath(arcCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        path.close()
        
        self.path = path.cgPath
        
        self.fillColor = fillColor
        
        if UIColor.white.cgColor == fillColor {
            self.strokeColor = UIColor.black.cgColor
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SquareShape

final class SquareShape: CAShapeLayer, ShapeLayerProtocol {
    // MARK: Init
    
    required init(size: CGSize, fillColor: CGColor) {
        super.init()
        
        let edgeSize = ([size.width, size.height].min() ?? 0)
        let maxSize = ([size.width, size.height].max() ?? 0)
        
        let centerX: CGFloat
        let centerY: CGFloat
        
        if maxSize == size.height {
            centerY = (size.height - edgeSize) / 2
            centerX = 0
        } else if maxSize == size.width {
            centerY = 0
            centerX = (size.width - edgeSize) / 2
        } else {
            centerY = 0
            centerX = 0
        }
        
        let rect = CGRect(x: centerX, y: centerY, width: edgeSize, height: edgeSize)
        let path = UIBezierPath(rect: rect)
        path.close()
        
        self.path = path.cgPath
        
        self.fillColor = fillColor
        
        if UIColor.white.cgColor == fillColor {
            self.strokeColor = UIColor.black.cgColor
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
