//
//  RecordsTableViewViewModelType.swift
//  Cards
//
//  Created by macbook on 17.04.2023.
//

import UIKit

// MARK: - Protocol

protocol RecordsTableViewViewModelType {
    // MARK: - Properties
    
    var title: String { get }
    var cellReuseIdentifier: String { get }
    var largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode { get }
    var items: [Int] { get }
    
    // MARK: - Methods
    
    func numberOfRowsInSection() -> Int
    func getCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func header(for section: Int) -> String?
    func footer(for section: Int) -> String?
    func getViewModel(for number: Int) -> RecordsTableViewViewModelType?
}
