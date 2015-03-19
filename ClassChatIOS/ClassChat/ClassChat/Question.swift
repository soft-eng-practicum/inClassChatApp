//
//  Question.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation

class Question {

    var question: String!
    var commentList = [Comment]()
    
    init(question: String) {
        self.question = question
    }
    
}