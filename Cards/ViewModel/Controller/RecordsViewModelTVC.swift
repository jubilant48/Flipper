//
//  RecordsViewModelTVC.swift
//  Cards
//
//  Created by macbook on 08.05.2023.
//

import UIKit

final class RecordsViewModelTVC: RecordsTableViewViewModelType {
    // MARK: - Enumeration
    
    enum RecordsNameSpaces: String {
        case title = "Рекорды"
        case sectionTitle = "🏆 "
        case cellReuseIdentifier = "RecordCell"
    }
    
    // MARK: - Properties
    
    private let storageService = StorageService.shared
    
    private var records: [Record] {
        var records: [Record] = []
        
        do {
            let recordsData = try storageService.getRecords(at: numberOfCardPairs, and: numberOfTypes, and: numberOfColors)
            recordsData.forEach { recordData in
                let record: Record = Record(numberOfPairsCards: recordData.numberOfPairsCards,
                                    numberOfTypes: recordData.numberOfTypes,
                                    numberOfColors: recordData.numberOfColors,
                                    second: recordData.second,
                                    date: recordData.date ?? Date(),
                                    flips: recordData.flips)
                
                records.append(record)
            }
            
        } catch let error {
            print("Error in set for number of pairs cards\nDescription: \(error.localizedDescription)")
        }
        
        records.sort { lhs, rhs in
            if lhs.second == rhs.second {
                if lhs.flips == rhs.flips {
                    return lhs.date < rhs.date
                    
                }
                return lhs.flips < rhs.flips
            }
            
            return lhs.second < rhs.second
        }
        
        return records
    }
    
    var numberOfCardPairs: Int
    var numberOfTypes: Int
    var numberOfColors: Int
    
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode = .never
    var title: String { RecordsNameSpaces.title.rawValue }
    var cellReuseIdentifier: String { RecordsNameSpaces.cellReuseIdentifier.rawValue }
    var items: [Int] { records.map { Int($0.flips) }}
    
    // MARK: - Init
    
    init(numberOfCardPairs: Int, numeberOfTypes: Int, numberOfColors: Int) {
        self.numberOfCardPairs = numberOfCardPairs
        self.numberOfTypes = numeberOfTypes
        self.numberOfColors = numberOfColors
    }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int {
        return items.count
    }
    
    func header(for section: Int) -> String? {
        switch section {
        case 0:
            return RecordsNameSpaces.sectionTitle.rawValue + "\(numberOfCardPairs) - \(numberOfTypes) - \(numberOfColors)"
        default:
            return nil
        }
    }
    
    func footer(for section: Int) -> String? {
        switch section {
        case 0:
            return "В ячейке рекорда предсталено время игры, количество перерворотов карт, дата и время оканчания партии, и место в таблице рекордов."
        default:
            return nil
        }
    }
    
    func getCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! RecordCell
        
        let viewModel = viewModel(for: indexPath)
        cell.viewModel = viewModel

        return cell
    }
    
    func getViewModel(for number: Int) -> RecordsTableViewViewModelType? {
        return nil
    }
    
    private func viewModel(for indexPath: IndexPath) -> RecordTableViewCellViewModelType {
        let record = records[indexPath.row]
        let viewModel = RecordTVViewModelCell(place: indexPath.row + 1,
                                              time: Int(record.second),
                                              date: record.date,
                                              score: Int(record.flips))
        
        return viewModel
    }
}
