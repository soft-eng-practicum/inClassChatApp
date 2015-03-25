//
//  AddCourseViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/13/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class AddCourseViewController: UIViewController {
    
    
    @IBOutlet weak var courseField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //THIS WAS MADE MOSTLY BY GUESSWORK
    @IBAction func addCoursePressed(sender: UIButton) {
        
        var backend: Backend = Backend()
        
        func onSuccess(credentials:NSDictionary) {
            
            CurrentUser.sharedInstance.user.CourseList.append(Course(title: course["course_name"], description: description.text)
            
            performSegueWithIdentifier("unwindAddCourse", sender: self)
        }
        
        backend.enrollUserInCourse(CurrentUser.sharedInstance.user.user_id, course_name: courseField.text, onSuccess: onSuccess())
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

    }
}