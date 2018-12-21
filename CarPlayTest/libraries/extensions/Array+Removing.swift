//
//  Array+Removing.swift
//  EsteeHR
//
//  Created by Dmitry Lernatovich on 4/18/16.
//  Copyright © 2016 Magnet. All rights reserved.
//

import Foundation
// Swift 2 Array Extension
extension Array where Element: Equatable {
    
    mutating func removeObject(object: Element?) {
        if(object == nil){
            return;
        }
        
        if let index = self.index(of: object!) {
            self.remove(at: index)
        }
    }
    
    mutating func removeObjectsInArray(array: [Element]?) {
        if(array == nil){
            return;
        }
        
        for object in array! {
            self.removeObject(object: object)
        }
    }
    
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }
}
