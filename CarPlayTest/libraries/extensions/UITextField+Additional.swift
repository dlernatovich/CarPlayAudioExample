//
//  UITextField+Additional.swift
//  MoDo
//
//  Created by Dmitry Lernatovich on 1/16/18.
//  Copyright © 2018 MoDo. All rights reserved.
//

import UIKit

extension UITextField {
    
    /// {@link UIColor} instance of the border color
    @IBInspectable var clearButtonColor: UIColor? {
        set {
            self.updateClearButton(withColor: newValue);
        }
        get {
            return nil;
        }
    }
    
    /// Method which provide the updating of the clear button color
    fileprivate func updateClearButton(withColor color: UIColor?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {[weak self] in
            if let image = UIImage.init(named: "artlib_img_clear.png")?
                .withRenderingMode(.alwaysTemplate),
                let color = color {
                self?.modifyClearButton(with: image, withColor: color);
            }
        }
    }
    
    
    /// Method which provide the modfy of the clear button
    ///
    /// - Parameter image: {@link UIImage} instance
    fileprivate func modifyClearButton(with image : UIImage,
                                       withColor color: UIColor) {
        // Get height
        let height: CGFloat = self.frame.size.height - 16;
        // Create the custom button
        let clearButton = UIButton(type: .custom);
        // Customize buton
        clearButton.setImage(image, for: .normal);
        clearButton.frame = CGRect(x: 0, y: 0, width: height + 16, height: height);
        clearButton.contentMode = .scaleAspectFit;
        clearButton.addTarget(self, action: #selector(UITextField.customClear(_:)), for: .touchUpInside);
        // Customize the image
        clearButton.imageView?.contentMode = .scaleAspectFit;
        clearButton.imageView?.tintColor = color;
        rightView = clearButton;
        rightViewMode = .always;
    }
    
    /// Method which provide the custom clearing for the edit field
    ///
    /// - Parameter sender: {@link AnyObject} of the sender
    @objc func customClear(_ sender : AnyObject) {
        if let text = self.text, text.isEmpty == false {
            self.text = nil;
            if self.isEditing == false {
                let _ = self.delegate?.textFieldShouldClear?(self);
            }
        } else {
            if self.isEditing == true {
                let _ = self.delegate?.textFieldShouldClear?(self);
            }
        }
    }
}
