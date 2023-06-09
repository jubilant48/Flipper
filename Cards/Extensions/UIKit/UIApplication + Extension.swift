//
//  UIApplication + Extension.swift
//  Cards
//
//  Created by macbook on 30.01.2023.
//

import UIKit

// MARK: - Extension

extension UIApplication {
    // MARK: - Methods
    
    class func getTopViewController(base: UIViewController?) -> UIViewController? {
        // This code beneath for get rootViewController
        // let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        // let viewController = scene!.windows[0].rootViewController
        
        if let navigationController = base as? UINavigationController {
            return getTopViewController(base: navigationController.visibleViewController)
        } else if let tabBarController = base as? UITabBarController,
                  let selectedController = tabBarController.selectedViewController {
            return getTopViewController(base: selectedController)
        } else if let presentedController = base?.presentedViewController {
            return getTopViewController(base: presentedController)
        }
        
        return base
    }
}
