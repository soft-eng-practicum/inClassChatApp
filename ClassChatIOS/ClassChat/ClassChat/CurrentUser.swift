//
//  CurrentUser.swift
//  ClassChatTest
//
//  Created by Jake on 3/13/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class CurrentUser {
    class var sharedInstance: CurrentUser {
        struct Static {
            static let instance = CurrentUser()
        }
        return Static.instance
    }
    
    var user: User!
    
    func assignCurrentUser(user: User) {
        self.user = user
    }
    
    func checkForDuplicates(check: String) -> Bool {
        for(var i = 0; i < self.user.CourseList.count; i++) {
            if (user.CourseList[i].title == check) {
                return true
            }
        }
        return false
    }
    
}