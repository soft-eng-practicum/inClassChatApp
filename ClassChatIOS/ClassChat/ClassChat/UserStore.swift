//
//  UserStore.swift
//  ClassChatTest
//
//  Created by Jake on 3/12/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation


//THIS WILL BE SWITCHED OUT FOR THE DATABASE


//Stores classes to list to be retrieved later

class UserStore {
    class var sharedInstance: UserStore {
        struct Static {
            static let instance = UserStore()
        }
        return Static.instance
    }
    
    var userList: [User] = []
    
    func add(newUser: User) {
        userList.append(newUser)
    }
    
    func replace(newUser: User, atIndex index: Int) {
        userList[index] = newUser
    }
    
    func get(index: Int) -> User {
        return userList[index]
    }
    
    var count: Int {
        get {
            return userList.count
        }
    }
    
    func findUserNameIndex(username: String) -> Int {
        for(var i = 0; i < userList.count; i++) {
            if (userList[i].name == username) {
                return i
            }
        }
        return -1
    }
    
    func removeUserAtIndex(index: Int) {
        userList.removeAtIndex(index)
    }
}