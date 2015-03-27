//
//  AddCommentViewController.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class AddCommentViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    
    var selectedQuestion: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = selectedQuestion.content
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
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