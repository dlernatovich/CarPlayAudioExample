//
//  UIScrollView+Additional.swift
//  MoDo
//
//  Created by Dmitry Lernatovich on 11/16/18.
//  Copyright © 2018 MoDo. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool, shift: CGFloat = 0) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y + shift,width: 1,height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom(shift: CGFloat = 0) {
        let bottomOffset = CGPoint(x: 0, y: (contentSize.height - bounds.size.height + contentInset.bottom) + shift)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}
