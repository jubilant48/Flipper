//
//  NumberOfPairsCardsViewModelTVC.swift
//  Cards
//
//  Created by macbook on 17.04.2023.
//

import UIKit

final class NumberOfPairsCardsViewModelTVC: RecordsTableViewViewModelType {
    // MARK: - Enumeration
    
    enum NumberOfPairsCardsNameSpaces: String {
        case title = "Рекорды"
        case sectionTitle = "Количество карт"
        case emoji = "\u{1F0CF} "
        case cellReuseIdentifier = "NumberOfPairsCardsCell"
    }
    
    // MARK: - Properties
    
    private let storage = StorageService.shared
    
    private var setNumberOfPairsCards: Set<Int> {
        var setNumber: Set<Int> = []
        
        do {
            let records = try storage.getRecords()
            records.forEach { record in
                setNumber.insert(Int(record.numberOfPairsCards))
            }
            
        } catch let error {
            print("Error in set for number of pairs cards\nDescription: \(error.localizedDescription)")
        }
        
        return setNumber
    }
    
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode = .automatic
    var title: String { NumberOfPairsCardsNameSpaces.title.rawValue }
    var cellReuseIdentifier: String { NumberOfPairsCardsNameSpaces.cellReuseIdentifier.rawValue }
    var items: [Int] { Array(setNumberOfPairsCards).sorted(by: <) }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    func header(for section: Int) -> String? {
        switch section {
        case 0:
            return NumberOfPairsCardsNameSpaces.sectionTitle.rawValue
        default:
            return nil
        }
    }
    
    func footer(for section: Int) -> String? {
        switch section {
        case 0:
            return "Наименование таблицы рекордов представлена количеством 'Пар - Фигур - Цветов'"
        default:
            return nil
        }
    }
    
    func getCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        var content = cell.defaultContentConfiguration()
        
        content.text = NumberOfPairsCardsNameSpaces.emoji.rawValue + String(items[indexPath.row])
        cell.contentConfiguration = content

        return cell
    }
    
    func getViewModel(for number: Int) -> RecordsTableViewViewModelType? {
        return NumberOfTypesViewModelTVC(numberOfCardPairs: number)
    }
}
