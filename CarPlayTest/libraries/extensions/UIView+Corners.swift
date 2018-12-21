//
//  UIView+Corners.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/1/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

extension UIView {
    
	/// Method  which provide the corner rounding
	///
	/// - Parameters:
	///   - corners: {@link UIRectCorner} of the corners
	///   - radius: {@link CGFloat} of the radius
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: self.bounds,
		                        byRoundingCorners: corners,
		                        cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}
}
