//
//  Course.swift
//  ClassChatTest
//
//  Created by Jake on 3/11/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class Course {
    
    var title: String!
    var description: String!
    var course_id: Int!
    var questionList = [Question]()
    
    init(title: String, description: String, course_id: Int) {
        self.title = title
        self.description = description
        self.questionList = [Question]()
        self.course_id = course_id
    }
    
    func addQuestion(content: String, question_id: Int, user_id:Int, likes: Int) {
        self.questionList.append(Question(content: content, id: question_id, user_id: user_id, likes: likes))
    }
    
    func removeQuestion(indexNumber: Int) {
        self.questionList.removeAtIndex(indexNumber)
    }
    
}

