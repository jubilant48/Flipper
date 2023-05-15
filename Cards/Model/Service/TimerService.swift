//
//  TimerService.swift
//  Cards
//
//  Created by macbook on 08.04.2023.
//

import UIKit

// MARK: - Class

final class TimerService {
    // MARK: - Properties
    
    var timer: Timer?
    private var second: Int = 0
    var isRinning: Bool = true
    
     // MARK: - Init
    
    deinit {
        timer = nil
    }
    
    // MARK: - Operation with timer
    
    func createTimer(_ target: Any, selector: Selector) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: target, selector: selector, userInfo: nil, repeats: true)
    }
    
    func returnTime() -> String {
        return TimeFormatter.timeFormatted(second)
    }
    
    func startTime(target: Any, selector: Selector) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: target, selector: selector, userInfo: nil, repeats: true)
        
        isRinning = true
    }
    
    func stopTime() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Operation with second
    
    func returnSecond() -> Int {
        return second
        
    }
    
    func resetSecond() {
        second = 0
    }
    
    func increaseSecond() {
        second += 1
    }
    
    func setSecond(_ second: Int) {
        self.second = second
    }
}
