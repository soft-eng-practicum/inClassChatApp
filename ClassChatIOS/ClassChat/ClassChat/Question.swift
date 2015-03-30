//
//  Question.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Question {
    
    
    var content: String!
    var commentList = [Comment]()
    var likes: Int!
    var id: Int!
    var user_id: Int!
    var last_updated_at: String!
    
    init(content: String, id: Int, user_id: Int, likes: Int, last_updated_at: String) {
        self.content = content
        self.likes = likes
        self.id = id
        self.user_id = user_id
        self.last_updated_at = last_updated_at
    }
    
}