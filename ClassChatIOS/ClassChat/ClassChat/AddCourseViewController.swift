//
//  AddCourseViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/13/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class AddCourseViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    var course: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCoursePressed(sender: UIButton) {
        
        var backend: Backend = Backend()
        
        func onSuccess(credentials:NSDictionary)->() {
            
            let course_id:Int! = credentials["course_id"] as Int
            
            course = Course(title: courseField.text, description: "", course_id: course_id)
            CurrentUser.sharedInstance.user.CourseList.append(course)
            performSegueWithIdentifier("unwindAddCourse", sender: self)
        }
        
        backend.enrollUserInCourse(CurrentUser.sharedInstance.user.user_id, course_name: courseField.text, onSuccess: onSuccess)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

    }
}