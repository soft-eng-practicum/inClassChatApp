//
//  AddQuestionViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/15/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class AddQuestionViewController: UIViewController, UITextFieldDelegate {
    

    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var QuestionField: UITextField!
    
    var selectedCourse: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    @IBAction func saveQuestion(sender: AnyObject) {
        
        var backend: Backend = Backend()
        
        func onSuccess() {
            performSegueWithIdentifier("unwindAddQuestionSegue", sender: self)
        }
        
        backend.postQuestion(CurrentUser.sharedInstance.user.user_id, course_id: selectedCourse.course_id, question: QuestionField.text, onSuccess: onSuccess)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}