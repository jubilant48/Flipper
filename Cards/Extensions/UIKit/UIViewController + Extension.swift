//
//  UIViewController + Extension.swift
//  Cards
//
//  Created by macbook on 21.01.2023.
//

import UIKit

// MARK: - Extension of alerts

extension UIViewController {
    // MARK: - Methods
    
    func showErrorAlert(title: String = "Ошибка", description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "😨", style: .cancel)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    func showStartNewGameAlert(title: String = "Партия завершена!", description: String, acceptCompletion: (() -> Void)?, quitCompletion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .actionSheet)
        
        let newGameAction = UIAlertAction(title: "Навая игра", style: .default) { _ in
            acceptCompletion?()
        }
        
        let quitAction = UIAlertAction(title: "Выйти в меню", style: .destructive) { _ in
            quitCompletion?()
        }
        
        alertController.addAction(newGameAction)
        alertController.addAction(quitAction)
        
        self.present(alertController, animated: true)
    }
}

// MARK: - Extension of get safe area information

extension UIViewController {
    // MARK: - Methods
    
    func getTopPadding() -> CGFloat {
        return getWindow().safeAreaInsets.top
    }
    
    func getBottomPadding() -> CGFloat {
        return getWindow().safeAreaInsets.bottom
    }
    
    func getWindow() -> UIWindow {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = scene!.windows[0]
        
        return window
    }
}
