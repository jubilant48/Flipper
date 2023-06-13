//
//  BoardAnimationSelecting.swift
//  Cards
//
//  Created by macbook on 13.06.2023.
//

import UIKit

final class BoardAnimationSelecting: SelectTableViewViewModelType {
    // MARK: - Enumeration
    
    enum NameSpaces: String{
        case title = "Анимации"
        case cellReuseIdentifier = "BoardAnimationCell"
    }
    
    // MARK: - Properties
    
    private let settings = Settings.shared
    private let animations: [AnimationHelper.Animation] = [.swingInUFO, .catIsSleepingAndRolling]
    
    var title: String { NameSpaces.title.rawValue }
    var cellReuseIdentifier: String { NameSpaces.cellReuseIdentifier.rawValue }
    var itemsCount: Int { 1 }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return animations.count
    }
    
    func textForCell(forIndexPath indexPath: IndexPath) -> String {
        let text = animations[indexPath.row].rawValue
        
        return text
    }
    
    func isCheckmark(forIndexPath indexPath: IndexPath) -> Bool {
        let isCheckmark = textForCell(forIndexPath: indexPath) == settings.animationBoardGameView
        
        return isCheckmark
    }
    
    func operationForSelected(cell: UITableViewCell, indexPath: IndexPath, tableView: UITableView) {
        cell.accessoryType = .checkmark
        
        let cells = tableView.visibleCells
        
        for updateCell in cells {
            if cell == updateCell {
                continue
            } else {
                updateCell.accessoryType = .none
            }
        }
        
        rewriteItem(for: indexPath)
    }
    
    // MARK: - Settings handle
    
    private func rewriteItem(for indexPath: IndexPath) {
        settings.animationBoardGameView = textForCell(forIndexPath: indexPath)
    }
    
    func saveSettings() {
        settings.saveSettings()
    }
}
