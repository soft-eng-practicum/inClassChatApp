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
    var questionList = [Question]()
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
        self.questionList = [Question(question: "General")]
    }
    
    func addQuestion(questionName: String) {
        self.questionList.append(Question(question: questionName))
    }
    
    func removeQuestion(indexNumber: Int) {
        self.questionList.removeAtIndex(indexNumber)
    }
    
}

