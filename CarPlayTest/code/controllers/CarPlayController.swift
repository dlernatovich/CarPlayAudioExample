//
//  CarPlayController.swift
//  CarPlayTest
//
//  Created by dlernatovich on 12/13/18.
//  Copyright © 2018 dlernatovich. All rights reserved.
//

import UIKit
import CarPlay

class CarPlayController: UIViewController {

    open var window: CPWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad();
        if let window = self.window {
            let view = CarPlayView.init(frame: window.frame);
            view.isUserInteractionEnabled = true;
            self.view.addSubview(view);
        }
//        // Just an example of showing your own views in the VC that you are setting as root on the CPMapContentWindow
//        if mainView == nil {
//            mainView = Bundle.main.loadNibNamed("CarplayView", owner: self, options: nil)?.first as? UIView
//            mainView?.frame = view.bounds
//            if let mainViewUnwrapped = mainView {self.view.addSubview(mainViewUnwrapped)}
//        }
    }

}
