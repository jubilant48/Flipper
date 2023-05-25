//
//  NumberOfColorsViewModelTVC.swift
//  Cards
//
//  Created by macbook on 23.04.2023.
//

import UIKit

final class NumberOfColorsViewModelTVC: RecordsTableViewViewModelType {
    // MARK: - Enumeration
    
    enum NumberOfColorsNameSpaces: String {
        case title = "Рекорды"
        case sectionTitle = "Количество цветов"
        case emoji = "🎨 "
        case cellReuseIdentifier = "NumberOfColorCell"
    }
    
    // MARK: - Properties
    
    private let storageService = StorageService.shared
    
    private var setNumberOfColors: Set<Int> {
        var setNumber: Set<Int> = []
        
        do {
            let records = try storageService.getRecords(at: numberOfCardPairs, and: numberOfTypes)
            records.forEach { record in
                setNumber.insert(Int(record.numberOfColors))
            }
            
        } catch let error {
            print("Error in set for number of pairs cards\nDescription: \(error.localizedDescription)")
        }
        
        return setNumber
    }
    
    var numberOfCardPairs: Int
    var numberOfTypes: Int
    
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode = .never
    var title: String { NumberOfColorsNameSpaces.title.rawValue + " '\(numberOfCardPairs) - \(numberOfTypes)'" }
    var backButtonTitle: String { "\(numberOfCardPairs) - \(numberOfTypes)" }
    var cellReuseIdentifier: String { NumberOfColorsNameSpaces.cellReuseIdentifier.rawValue }
    var items: [Int] { Array(setNumberOfColors).sorted(by: <) }
    
    // MARK: - Init
    
    init(numberOfCardPairs: Int, numeberOfTypes: Int) {
        self.numberOfCardPairs = numberOfCardPairs
        self.numberOfTypes = numeberOfTypes
    }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    func header(for section: Int) -> String? {
        switch section {
        case 0:
            return NumberOfColorsNameSpaces.sectionTitle.rawValue
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
        
        content.text = NumberOfColorsNameSpaces.emoji.rawValue + String(items[indexPath.row])
        cell.contentConfiguration = content
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func getViewModel(for number: Int) -> RecordsTableViewViewModelType? {
        return RecordsViewModelTVC(numberOfCardPairs: numberOfCardPairs, numeberOfTypes: numberOfTypes, numberOfColors: number)
    }
}
