//
//  UIColor+Additional.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 8/5/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

extension UIColor {

	/**
	 Method which provide the create color from rgb example: r:255 g:255 b:255 a:50

	 - author: Dmitriy Lernatovich

	 - parameter red:   red 0-255
	 - parameter green: green 0-255
	 - parameter blue:  blue 0-255
	 - parameter alpha: alpha 0-100

	 - returns: color
	 */
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 100) -> UIColor {
		return UIColor(red: (red / 255), green: (green / 255), blue: (blue / 255), alpha: (alpha / 100));
	}

}
