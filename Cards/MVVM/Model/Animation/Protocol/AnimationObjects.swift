//
//  AnimationObjects.swift
//  Cards
//
//  Created by macbook on 07.06.2023.
//

import UIKit
import Lottie

// MARK: - Protocols

protocol AnimationObjects {
    var light: String { get }
    var dark: String { get }
    
    var loopMode: LottieLoopMode { get }
}
