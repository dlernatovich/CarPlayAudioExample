//
//  UIViewController+Additional.swift
//  MoDo
//
//  Created by Dmitry Lernatovich on 10/9/18.
//  Copyright © 2018 MoDo. All rights reserved.
//

import UIKit

/// Instance of the {@link OnNavigationControllerCallback}
typealias OnPreconfigurationCallback = (_ controller: UIViewController) -> Void;

// MARK: - Additional functional for the {@link UIViewController}
extension UIViewController {
    
    /// Method which provide the push view controller
    ///
    /// - Parameters:
    ///   - storyboard: {@link String} value of the storyboard name
    ///   - controller: {@link String} value of the controller name
    func pushController(withStoryboard storyboard: String?,
                        andController controller: String?,
                        withCallback callback: OnPreconfigurationCallback?) {
        if let storyboard = storyboard, let controller = controller {
            let storyboardObj = UIStoryboard.init(name: storyboard, bundle: nil);
            let controllerObj = storyboardObj.instantiateViewController(withIdentifier: controller);
            if let navigationController = self.navigationController {
                callback?(controllerObj);
                navigationController.show(controllerObj, sender: self);
            }
        }
    }
    
    /// Method which provide the push view controller
    ///
    /// - Parameters:
    ///   - storyboard: {@link String} value of the storyboard name
    ///   - controller: {@link String} value of the controller name
    func popController(withStoryboard storyboard: String?,
                       andController controller: String?,
                       withCallback callback: OnPreconfigurationCallback?) {
        if let storyboard = storyboard, let controller = controller {
            let storyboardObj = UIStoryboard.init(name: storyboard, bundle: nil);
            let controllerObj = storyboardObj.instantiateViewController(withIdentifier: controller);
            let navigationObj = UINavigationController.init(rootViewController: controllerObj);
            navigationObj.isToolbarHidden = true;
            navigationObj.isNavigationBarHidden = true;
//            let swipe = UISwipeGestureRecognizer(target: controllerObj, action: #selector(UIViewController.closeViewController));
//            swipe.direction = UISwipeGestureRecognizerDirection.down;
//            controllerObj.view.addGestureRecognizer(swipe);
            if let navigationController = self.navigationController {
                callback?(controllerObj);
                navigationController.show(navigationObj, sender: self);
            }
        }
    }
    
    /// Method which provide the push view controller
    ///
    /// - Parameters:
    ///   - storyboard: {@link String} value of the storyboard name
    ///   - controller: {@link String} value of the controller name
    func showAsDialog(withStoryboard storyboard: String?,
                      andController controller: String?,
                      withCallback callback: OnPreconfigurationCallback?) {
        if let storyboard = storyboard, let controller = controller {
            let storyboardObj = UIStoryboard.init(name: storyboard, bundle: nil);
            let controllerObj = storyboardObj.instantiateViewController(withIdentifier: controller);
            controllerObj.view.backgroundColor = .clear;
            controllerObj.modalPresentationStyle = .overFullScreen;
            controllerObj.modalTransitionStyle = .crossDissolve;
            callback?(controllerObj);
            self.present(controllerObj, animated: true, completion: nil);
        }
    }
    
    // MARK: - Close controller
    
    /// Method which provide the close of the controller
    func closeViewController() {
        if (self.navigationController != nil) {
            self.navigationController?.popViewController(animated: true);
        }
        self.dismiss(animated: true, completion: nil);
    }
    
    // MARK: - Storyboard
    
    /// Method which provide the instantiate storyboard
    ///
    /// - Parameter name: {@link String} value of the storyboard name
    func instantiateStoryboard(name: String?) {
        if let name = name {
            let storyboard: UIStoryboard = UIStoryboard.init(name: name, bundle: nil) ;
            if let controller = storyboard.instantiateInitialViewController() {
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController = controller;
                    window.makeKeyAndVisible();
                }
            }
        }
    }
    
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
