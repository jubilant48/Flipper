//
//  CardColorSelecting.swift
//  Cards
//
//  Created by macbook on 11.02.2023.
//

import UIKit

final class CardColorSelecting: SelectTableViewViewModelType {
    // MARK: - Enumeration
    
    enum NameSpaces: String {
        case title = "Цвета фигур"
        case cellReuseIdentifier = "CardColorCell"
    }
    
    // MARK: - Properties
    
    private let settings = Settings.shared
    private let cardColors: [CardColor] = [.red, .green, .black, .gray, .brown, .yellow, .purple, .orange, .white]
    
    var title: String { NameSpaces.title.rawValue }
    var cellReuseIdentifier: String { NameSpaces.cellReuseIdentifier.rawValue }
    var itemsCount: Int { settings.cardColors.count }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return cardColors.count
    }
    
    func textForCell(forIndexPath indexPath: IndexPath) -> String {
        let text = cardColors[indexPath.row].rawValue
        
        return text
    }
    
    func isCheckmark(forIndexPath indexPath: IndexPath) -> Bool {
        let isCheckmark = settings.cardColors.contains(textForCell(forIndexPath: indexPath))
        
        return isCheckmark
    }
    
    func operationForSelected(cell: UITableViewCell, indexPath: IndexPath, tableView: UITableView) {
        if isCheckmark(forIndexPath: indexPath) && itemsCount > 1 {
            cell.accessoryType = .none
            removeItem(forIndexPath: indexPath)
            
        } else if !isCheckmark(forIndexPath: indexPath) {
            cell.accessoryType = .checkmark
            insertItem(forIndexPath: indexPath)
        }
    }
    
    // MARK: - Settings handle
    
    private func removeItem(forIndexPath indexPath: IndexPath) {
        settings.cardColors.remove(textForCell(forIndexPath: indexPath))
    }
    
    private func insertItem(forIndexPath indexPath: IndexPath) {
        settings.cardColors.insert(textForCell(forIndexPath: indexPath))
    }
    
    func saveSettings() {
        settings.saveSettings()
    }
}
