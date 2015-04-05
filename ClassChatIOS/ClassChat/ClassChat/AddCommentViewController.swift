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
    

    @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var commentField: UITextView!
    var selectedQuestion: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentField.becomeFirstResponder()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        buttonConstraint.constant = 0
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                buttonConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                buttonConstraint.constant = 0
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
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