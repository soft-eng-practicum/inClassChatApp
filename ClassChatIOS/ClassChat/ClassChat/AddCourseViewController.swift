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
    
    
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    var course: Course!
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addCoursePressed(sender: UIButton) {
        
        var backend: Backend = Backend()
        
        func onSuccess(credentials:NSDictionary)->() {
            
            print(credentials)
            
            let course_id:Int! = credentials["course_id"] as Int
            
            course = Course(title: courseField.text, description: descriptionField.text, course_id: course_id)
            CurrentUser.sharedInstance.user.CourseList.append(course)
            performSegueWithIdentifier("unwindAddCourse", sender: self)
        }
        
        backend.enrollUserInCourse(CurrentUser.sharedInstance.user.user_id, course_name: courseField.text, onSuccess: onSuccess)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

    }
}