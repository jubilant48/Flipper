//
//  NumberOfTypesViewModelTVC.swift
//  Cards
//
//  Created by macbook on 23.04.2023.
//

import UIKit

final class NumberOfTypesViewModelTVC: RecordsTableViewViewModelType {
    // MARK: - Enumeration
    
    enum NumberOfTypesNameSpaces: String {
        case title = "Рекорды"
        case sectionTitle = "Количество фигур"
        case emoji = "\u{1F3B2} "
        case cellReuseIdentifier = "NumberOfTypesCell"
    }
    
    // MARK: - Properties
    
    private let storageServive = StorageService.shared
    
    private var setNumberOfTypes: Set<Int> {
        var setNumber: Set<Int> = []
        
        do {
            let records = try storageServive.getRecords(at: numberOfCardPairs)
            records.forEach { record in
                setNumber.insert(Int(record.numberOfTypes))
            }
            
        } catch let error {
            print("Error in set for number of pairs cards\nDescription: \(error.localizedDescription)")
        }
        
        return setNumber
    }
    
    var numberOfCardPairs: Int
    
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode = .never
    var title: String { NumberOfTypesNameSpaces.title.rawValue + " '\(numberOfCardPairs)'" }
    var backButtonTitle: String { "\(numberOfCardPairs)" }
    var cellReuseIdentifier: String { NumberOfTypesNameSpaces.cellReuseIdentifier.rawValue }
    var items: [Int] { Array(setNumberOfTypes).sorted(by: <) }
    
    // MARK: - Init
    
    init(numberOfCardPairs: Int) {
        self.numberOfCardPairs = numberOfCardPairs
    }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    func header(for section: Int) -> String? {
        switch section {
        case 0:
            return NumberOfTypesNameSpaces.sectionTitle.rawValue
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
        
        content.text = NumberOfTypesNameSpaces.emoji.rawValue + String(items[indexPath.row])
        cell.contentConfiguration = content
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func getViewModel(for number: Int) -> RecordsTableViewViewModelType? {
        return NumberOfColorsViewModelTVC(numberOfCardPairs: numberOfCardPairs, numeberOfTypes: number)
    }
}
