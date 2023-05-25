//
//  SelectCardBackViewModelTVC.swift
//  Cards
//
//  Created by macbook on 11.02.2023.
//

import UIKit

final class SelectCardBackViewModelTVC: SelectTableViewViewModelType {
    // MARK:  - Enumeration
    
    enum SelectCardBackNameSpaces: String {
        case title = "Рубашки"
        case cellReuseIdentifier = "BackSideCardCell"
    }
    
    // MARK: - Properties
    
    private let settings = Settings.shared
    private let cardBackSides: [CardBackSide] = [.circle, .line]
    
    var title: String { SelectCardBackNameSpaces.title.rawValue }
    var cellReuseIdentifier: String { SelectCardBackNameSpaces.cellReuseIdentifier.rawValue }
    var itemsCount: Int { settings.cardBackSides.count }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return cardBackSides.count
    }
    
    func textForCell(forIndexPath indexPath: IndexPath) -> String {
        let text = cardBackSides[indexPath.row].rawValue
        
        return text
    }
    
    func isCheckmark(forIndexPath indexPath: IndexPath) -> Bool {
        let isCheckmark = settings.cardBackSides.contains(textForCell(forIndexPath: indexPath))
        
        return isCheckmark
    }
    
    // MARK: - Settings handle
    
    func removeItem(forIndexPath indexPath: IndexPath) {
        settings.cardBackSides.remove(textForCell(forIndexPath: indexPath))
    }
    
    func insertItem(forIndexPath indexPath: IndexPath) {
        settings.cardBackSides.insert(textForCell(forIndexPath: indexPath))
    }
    
    func saveSettings() {
        settings.saveSettings()
    }
}
