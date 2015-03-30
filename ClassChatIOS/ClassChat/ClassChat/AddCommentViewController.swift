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
            var backend: Backend = Backend()
            
            func onSuccess() {
                performSegueWithIdentifier("unwindAddComment", sender: self)
            }
            
            backend.postAnswer(CurrentUser.sharedInstance.user.user_id, question_id: selectedQuestion.id, answer: commentField.text, onSuccess: onSuccess)
    }
}