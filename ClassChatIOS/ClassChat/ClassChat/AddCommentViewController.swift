//
//  AddCommentViewController.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class AddCommentViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    
    
    
    var selectedQuestion: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = selectedQuestion.question
    }
    
    @IBAction func saveComment(sender: AnyObject) {
        if (self.commentField.text.isEmpty) {
            let alert = UIAlertView()
            alert.title = "No Text"
            alert.message = "Please type a question"
            alert.addButtonWithTitle("Ok")
            alert.show()
        } else {
            self.selectedQuestion.commentList.append(Comment(text: commentField.text))
        }
    }
    
    
}