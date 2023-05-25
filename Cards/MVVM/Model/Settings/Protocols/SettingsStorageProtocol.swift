//
//  SettingsStorageProtocol.swift
//  Cards
//
//  Created by macbook on 21.01.2023.
//

import UIKit

protocol SettinsStorageProtocol {
    // MARK: - Methods
    
    func loadSettings() throws
    func saveSettings()
}
