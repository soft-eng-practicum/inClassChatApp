//
//  User.swift
//  ClassChat
//
//  Created by Jake on 3/5/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

// jakemor.com/

import Foundation

class User {
    
    var user_id: Int!
    var name: String!
    var password: String!
    var lastName: String!
    var firstName: String!
    var school_id: String!
    
    init(name: String, password: String, firstName: String, lastName: String, school_id: String, user_id: Int) {
        self.name = name
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.school_id = school_id
        self.user_id = user_id
    }
    
    var CourseList: [Course] = [] // = [Course(title: "My Questions", description: "Questions I have asked")]
    var myQuestions: [String] = []
    
    func add(newClass: Course) {
        CourseList.append(newClass)
    }
    
    func get(index: Int) -> Course {
        return CourseList[index]
    }
    
    func removeClassWithName(name: String) {
        for (var i = 0; i < CourseList.count; i++) {
            if (CourseList[i].title == name) {
                CourseList.removeAtIndex(i)
                return
            }
        }
    }
}