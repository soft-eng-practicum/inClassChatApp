//
//  User.swift
//  ClassChat
//
//  Created by Jake on 3/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

// jakemor.com/


//IN THE FUTURE, USER WILL BE TAKEN DIRECTLY FROM DB AND PLACED INTO THE SHARED INSTANCE CurrentUser

import Foundation

class User {
    
    var name: String!
    var password: String!
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    var CourseList: [Course] = [Course(title: "My Questions", description: "Questions I have asked")]
    var myQuestions: [String] = []
    
    func add(newClass: Course) {
        CourseList.append(newClass)
    }
    
    func get(index: Int) -> Course {
        return CourseList[index]
    }
    
    func removeClassAtIndex(index: Int) {
        CourseList.removeAtIndex(index)
    }
}