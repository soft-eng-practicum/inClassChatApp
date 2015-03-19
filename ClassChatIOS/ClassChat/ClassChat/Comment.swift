//
//  Comment.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Comment {
    
    var text: String!
    var points = 0
    
    init(text: String) {
        self.text = text
    }
    
    func addPoint() {
        self.points += 1
    }
    
    func losePoint() {
        self.points -= 1
    }
    
}