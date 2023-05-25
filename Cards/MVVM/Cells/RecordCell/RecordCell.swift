//
//  RecordCell.swift
//  Cards
//
//  Created by macbook on 08.05.2023.
//

import UIKit

final class RecordCell: UITableViewCell {
    // MARK: - Properties
    
    static let identifier = "RecordCell"
    
    private var placeLabel = UILabel(text: "1")
    private var timeLabel = UILabel(text: "00:01")
    private var dateLabel = UILabel(text: "01.01.1973 в 00:00")
    private var scoreLabel = UILabel(text: "0")
    
    var viewModel: RecordTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            
            placeLabel.text = viewModel.place
            timeLabel.text = viewModel.time
            dateLabel.text = viewModel.date
            scoreLabel.text = viewModel.score
            
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customizeElement()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customizeElement()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - Setup elements 

extension RecordCell {
    private func customizeElement() {
        // Set content hugging priority
        timeLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
        dateLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .horizontal)
        scoreLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        
        // Configure placeLabel
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.textAlignment = .center
        
        // Configure timeLabel
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure dateLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = .secondaryLabel
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        
        // Configure scoreLabel
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
    }
    
    private func setupConstraints() {
        // Adding subview
        contentView.addSubview(placeLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(scoreLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            placeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            placeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            placeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -8),
            placeLabel.heightAnchor.constraint(equalToConstant: 54),
            placeLabel.widthAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: placeLabel.trailingAnchor, constant: 8),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            timeLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -8),
            timeLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -8),
            timeLabel.heightAnchor.constraint(equalToConstant: 24)
        ])

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: placeLabel.trailingAnchor, constant: 8),
            dateLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            dateLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -8),
            dateLabel.heightAnchor.constraint(equalToConstant: 12)
        ])

        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 8),
            scoreLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            scoreLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            scoreLabel.heightAnchor.constraint(equalToConstant: 54),
            scoreLabel.widthAnchor.constraint(equalToConstant: 45)
        ])
    }
}
