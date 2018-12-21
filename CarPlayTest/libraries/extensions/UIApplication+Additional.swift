//
//  UIApplication+Additional.swift
//  MoDo
//
//  Copyright © 2017 Magnet. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /// Method which provide the getting of the top view controller
    ///
    /// - Parameter controller: view controller
    /// - Returns: top view controller
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
