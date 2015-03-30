//
//  Comment.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Comment {
    
    var user:String!
    var text: String!
    var points = 0
    
    init(text: String, user: String) {
        self.text = text
        self.user = user
    }
    
    func addPoint() {
        self.points += 1
    }
    
    func losePoint() {
        self.points -= 1
    }
    
}