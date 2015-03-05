//
//  ClassStore.swift
//  ClassChat
//
//  Created by Jake on 3/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation


//Stores classes to list to be retrieved later

class ClassStore {
    class var sharedInstance: ClassStore {
        struct Static {
            static let instance = ClassStore()
        }
        return Static.instance
    }
    
    var classes: [Class] = []
    
    func add(newClass: Class) {
        classes.append(newClass)
    }
    
    func replace(newClass: Class, atIndex index: Int) {
        classes[index] = newClass
    }
    
    func get(index: Int) -> Class {
        return classes[index]
    }
    
    var count: Int {
        get {
            return classes.count
        }
    }
    
    func removeClassAtIndex(index: Int) {
        classes.removeAtIndex(index)
    }
}