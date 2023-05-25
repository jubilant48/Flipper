//
//  TimerButton.swift
//  Cards
//
//  Created by macbook on 25.05.2023.
//

import UIKit

// MARK: - Class

final class TimerButton: UIButton {
    // MARK: - Properties
    
    let hiddenLabel = UILabel(text: "Play")
    
    private var isOn: Bool = true
    
    // MARK: - Init
    
    init(frame: CGRect, text: String, hiddenText: String = " Play") {
        super.init(frame: frame)
        
        setTitle(text, for: .normal)
        self.hiddenLabel.attributedText = attributetText(hiddenText)
        
        customizeElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func attributetText(_ text: String) -> NSMutableAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "play.fill")?.withTintColor(.getGreen())
        let attributedStringColor = [NSAttributedString.Key.foregroundColor : UIColor.getBlue()]
        
        let fullString = NSMutableAttributedString()
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: text, attributes: attributedStringColor))
        
        return fullString
    }
    
    private func customizeElements() {
        // Configure cell
        layer.cornerRadius = 10
        
        // Configure titleLabel
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.textAlignment = .center
        
        // Configure hideLabel
        hiddenLabel.translatesAutoresizingMaskIntoConstraints = false
        hiddenLabel.textAlignment = .center
        hiddenLabel.layer.opacity = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isOn.toggle()
        
        if isOn {
            UIView.animate(withDuration: 0.5) {
                self.layer.borderColor = UIColor.clear.cgColor
                self.layer.borderWidth = 0
                self.setTitleColor(.getBlue(), for: .normal)
                self.titleLabel?.transform = .identity
                self.hiddenLabel.layer.opacity = 0
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.layer.borderColor = UIColor.getRed().cgColor
                self.layer.borderWidth = 3
                self.hiddenLabel.layer.opacity = 1.0
                self.setTitleColor(.getRed(), for: .normal)
                self.titleLabel?.transform = CGAffineTransform(scaleX: 0.6, y: 0.6).translatedBy(x: 0, y: 20)
            }
        }
    }
}

// MARK: - Setup constarints

extension TimerButton {
    private func setupConstraints() {
        // Adding subview
        addSubview(hiddenLabel)
        
        // Setup constaraints
        NSLayoutConstraint.activate([
            hiddenLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            hiddenLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
}
