//
//  CourseStore.swift
//  ClassChatTest
//
//  Created by Jake on 3/13/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

//THIS WILL BE SWITCHED OUT FOR THE DATABASE


//Stores classes to list to be retrieved later

class CourseStore {
    class var sharedInstance: CourseStore {
        struct Static {
            static let instance = CourseStore()
        }
        return Static.instance
    }
    
    var courseDB: [Course] = []
    
    func add(course: Course) {
        courseDB.append(course)
    }
    
    func replace(course: Course, atIndex index: Int) {
        courseDB[index] = course
    }
    
    func get(index: Int) -> Course {
        return courseDB[index]
    }
    
    var count: Int {
        get {
            return courseDB.count
        }
    }
    
    func findCourseIndex(courseName: String) -> Int {
        for(var i = 0; i < courseDB.count; i++) {
            if (courseDB[i].title == courseName) {
                return i
            }
        }
        return -1
    }
    
    func removeCourseAtIndex(index: Int) {
        courseDB.removeAtIndex(index)
    }
}