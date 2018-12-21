//
//  UINavigationBar+Additional.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 8/5/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import UIKit

extension UINavigationBar {

	/**
	 Method which provide the customization

	 - author: Dmitriy Lernatovich

	 - parameter backgroundColor: background color
	 - parameter titleColor:      title color
	 - parameter tintColor:       tint color
	 */
	final func customize(backgroundColor: UIColor? = nil, titleColor: UIColor? = nil, tintColor: UIColor? = nil, needClear: Bool = false) {
		// Clear customization
		if (needClear == true) {
			DispatchQueue.main.async(execute: { [weak self] in
				self?.clearCustomization();
			});
		}
		// Set background color
		if (backgroundColor != nil) {
			DispatchQueue.main.async(execute: { [weak self] in
				self?.barTintColor = backgroundColor;
			});
		}

		// Title color
		if (titleColor != nil) {
			DispatchQueue.main.async(execute: { [weak self] in
                self?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor!];
			});
		}

		// Tint color
		if (tintColor != nil) {
			DispatchQueue.main.async(execute: { [weak self] in
				self?.tintColor = tintColor;
			});
		}
	}

	/**
	 Method which provide the clearing of the customization

	 - author: Dmitriy Lernatovich
	 */
	final func clearCustomization() {
		DispatchQueue.main.async(execute: { [weak self] in
			self?.barTintColor = nil;
            self?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black];
			self?.tintColor = UIColor.blue;
		});
	}

	/**
	 Method which provide the backing up colors from navigation bar

	 - author: Dmitriy Lernatovich

	 - parameter backgroundColor: background color
	 - parameter titleColor:      title color
	 - parameter tintColor:       tint color
	 */
	final func backup( backgroundColor: inout UIColor?, titleColor: inout UIColor?, tintColor: inout UIColor?) {
		var r: CGFloat = 0;
		var g: CGFloat = 0;
		var b: CGFloat = 0;
		var a: CGFloat = 0;

		if let color = self.barTintColor {
			color.getRed(&r, green: &g, blue: &b, alpha: &a);
			backgroundColor = UIColor(red: r, green: g, blue: b, alpha: a);
		}
        if let color = self.titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor {
			color.getRed(&r, green: &g, blue: &b, alpha: &a);
			titleColor = UIColor(red: r, green: g, blue: b, alpha: a);
		}
		if let color = self.tintColor {
			color.getRed(&r, green: &g, blue: &b, alpha: &a);
			tintColor = UIColor(red: r, green: g, blue: b, alpha: a);
		}
	}

}
