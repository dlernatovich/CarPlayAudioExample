//
//  CarPlayComposer.swift
//  CarPlayTest
//
//  Created by dlernatovich on 12/17/18.
//  Copyright © 2018 dlernatovich. All rights reserved.
//

import UIKit
import CarPlay
import MediaPlayer

/// Class which provide the car play composer
@available(iOS 12.0, *)
class CarPlayComposer: NSObject {

    /// Instance of the {@link String}
    fileprivate static let K_TITLE: String = "Car Play";

    /// Instance of the {@link UIApplication}
    fileprivate weak var application: UIApplication?;

    /// Instance of the {@link CPInterfaceController}
    fileprivate weak var interfaceController: CPInterfaceController?;

    /// Instance of the {@link CPWindow}
    fileprivate weak var window: CPWindow?;

    /// Method which provide the crate of the {@link CarPlayComposer} with parameters
    ///
    /// - Parameters:
    ///   - application: instance of the {@link UIApplication}
    ///   - interfaceController: instance of the {@link CPInterfaceController}
    ///   - window: instance of the {@link CPWindow}
    init(withApplication application: UIApplication?,
         withController interfaceController: CPInterfaceController?,
         withWindow window: CPWindow?) {
        super.init();
        self.application = application;
        self.interfaceController = interfaceController;
        self.window = window;
        self.onInitInterface();

        let tabBarView = UITabBar.init(frame: self.window!.frame);

        let tabController = UITabBarController.init();
        let navController = UINavigationController.init(rootViewController: tabController);
        let controller1 = CarPlayController();
        controller1.title = "Radio Stations"
        controller1.window = window;
        let controller2 = CarPlayController();
        controller2.window = window;
        controller2.title = "Favorites"
        tabController.setViewControllers([controller1, controller2], animated: true);
        tabController.view.frame = window!.frame;
        self.window?.rootViewController = navController;
    }

    /// Method which provide the init interface
    fileprivate func onInitInterface() {
//        self.interfaceController?.setRootTemplate(self.getRootTemplate(), animated: true);
    }

}

//// MARK: - CPListTemplateDelegate
//extension CarPlayComposer : CPListTemplateDelegate {
//
//    /// Class which provide the list template clicking
//    ///
//    /// - Parameters:
//    ///   - listTemplate: instance of the {@link CPListTemplate}
//    ///   - item: instance of the {@link CPListItem}
//    ///   - completionHandler: handler callback
//    func listTemplate(_ listTemplate: CPListTemplate,
//                      didSelect item: CPListItem,
//                      completionHandler: @escaping () -> Void) {
//        let mapTemplate = CPMapTemplate.init();
//        self.interfaceController?.pushTemplate(mapTemplate, animated: true);
//    }
//
//}

// MARK: - Get root template
extension CarPlayComposer {

    /// Method which provide the getting of the root template
    ///
    /// - Returns: instance of the {@link CPTemplate}
    fileprivate func getRootTemplate() -> CPTemplate {
        let template = CPTemplate();
        return template;
    }

}

// MARK: - UITabBarControllerDelegate
extension CarPlayComposer: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }

}

// MARK: - Example code

//    /// Method which provide the getting of the {@link CPTemplate}
//    ///
//    /// - Returns: instance of the {@link CPTemplate}
//    fileprivate func getTemplate() -> CPTemplate {
//        if (self.template == nil) {
//            let template = CPListTemplate.init(title: CarPlayComposer.K_TITLE, sections:self.getSections());
//            template.delegate = self;
//            self.template = template;
//        }
//        return self.template!;
//    }

//    /// Method which provide the getting of the list of sections
//    ///
//    /// - Returns: list of the {@link CPListSection}
//    fileprivate func getSections() -> [CPListSection] {
//        var items: [CPListSection] = [];
//        for i in 0...10 {
//            items.append(CPListSection.init(items: self.getItems(),  header: "\(i+1)",  sectionIndexTitle: nil));
//        }
//        return items;
//    }
//
//    /// Method which provide the getting items
//    ///
//    /// - Returns: list of the {@link CPListItem}
//    fileprivate func getItems() -> [CPListItem] {
//        var items: [CPListItem] = [];
//        for i in 0...11 {
//            items.append(CPListItem.init(text: "Item \(i + 1)", detailText: "aksdlkajsdlkajsdlk asdj lkajsdlkajsdlkajsdlkajsdlkjas kldjasdjkl lkajlk", image: nil, showsDisclosureIndicator: true));
//        }
//        return items;
//    }
