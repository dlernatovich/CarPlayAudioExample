//
//  CarPlayView.swift
//  CarPlayTest
//
//  Created by dlernatovich on 12/18/18.
//  Copyright © 2018 dlernatovich. All rights reserved.
//

import UIKit

class CarPlayView: UIView {

    /// Constructor which provide the view initialization from frame
    ///
    /// - Parameter frame: instance of the {@link CGRect}
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.onInitCustomView();
    }
    
    /// Constructor which provide to create the view from coder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.onInitCustomView();
    }
    
    /// Method which provide the view initialization
    fileprivate final func onInitCustomView() {
        if let className = NSStringFromClass(self.classForCoder)
            .components(separatedBy: ".").last,
            let view = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as? UIView {
            self.addSubview(view);
            view.frame = self.bounds;
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth];
            self.onCreateView();
        }
    }
    
    /// Method which provide the view creating
    fileprivate func onCreateView() {
        // TODO: Create action here
    }
    
    
    @IBAction func onActionClicked(_ sender: Any) {
        print("sadsadsad")
    }
    
}
