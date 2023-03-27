//
//  SoundService.swift
//  Cards
//
//  Created by macbook on 27.03.2023.
//

import UIKit
import AVFoundation

// MARK: Class

final class SoundService {
    // MARK: Propertis
    
    private static var audioPlayer: AVPlayer!
    
    // MARK: Methods

    static func play(sound: SoundNames) throws {
        var url: URL
        
        switch sound {
        case .flip:
            url = try findSound(name: SoundNames.flip.rawValue)
        case .remove:
            url = try findSound(name: SoundNames.remove.rawValue)
        case .pushToLimits:
            url = try findSound(name: SoundNames.pushToLimits.rawValue)
        }
        
        audioPlayer = AVPlayer(url: url)
        audioPlayer.volume = 0.15
        
        audioPlayer.play()
    }
    
    private static func findSound(name: String) throws -> URL {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            throw SoundError.sondNotFound
        }
        
        let url = URL(fileURLWithPath: path)
        
        return url
    }
}
