//
//  Animations.swift
//  Cards
//
//  Created by macbook on 07.06.2023.
//

import UIKit
import Lottie

// MARK: - Structures

struct CatIsSleepingAndRolling: AnimationObjects {
    var light: String { "cat_is_sleeping_and_rolling_light" }
    var dark: String { "cat_is_sleeping_and_rolling_dark" }
    
    var loopMode: LottieLoopMode { .autoReverse }
}

struct SwingInUFO: AnimationObjects {
    var light: String { "swing_in_ufo_light" }
    var dark: String { "swing_in_ufo_dark" }
    
    var loopMode: LottieLoopMode { .loop }
}
