//
//  SettingsTVCell.swift
//  Cards
//
//  Created by macbook on 17.02.2023.
//

import UIKit

class SettingsTVCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier = "SettingsCell"
    
    private var itemName: String? = nil {
        didSet {
            if oldValue != itemName {
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    var viewModel: SettingsTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            self.itemName = viewModel.title
        }
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = defaultContentConfiguration().updated(for: state)
        
        content.text = itemName
        
        self.contentConfiguration = content
    }

}
