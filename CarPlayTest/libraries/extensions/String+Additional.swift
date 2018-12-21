//
//  String+Additional.swift
//  MIO Family
//
//  Created by Dmitry Lernatovich on 7/28/16.
//  Copyright © 2016 magnet. All rights reserved.
//

import Foundation

extension String {

	var lastPathComponent: String {
		get {
			return (self as NSString).lastPathComponent
		}
	}

	var pathExtension: String {
		get {
			return (self as NSString).pathExtension
		}
	}

	var stringByDeletingLastPathComponent: String {
		get {
			return (self as NSString).deletingLastPathComponent
		}
	}

	var stringByDeletingPathExtension: String {
		get {
			return (self as NSString).deletingPathExtension
		}
	}

	var pathComponents: [String] {
		get {
			return (self as NSString).pathComponents
		}
	}

	var length: Int {
		get {
			return self.characters.count;
		}
	}

	func stringByAppendingPathComponent(path: String) -> String {
		let nsSt = self as NSString
		return nsSt.appendingPathComponent(path)
	}

	func stringByAppendingPathExtension(ext: String) -> String? {
		let nsSt = self as NSString
		return nsSt.appendingPathExtension(ext)
	}
    
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func lowercasingFirstLetter() -> String {
        let first = String(characters.prefix(1)).lowercased()
        let other = String(characters.dropFirst())
        return first + other
    }
    
    mutating func lowercaseFirstLetter() {
        self = self.lowercasingFirstLetter()
    }
}
