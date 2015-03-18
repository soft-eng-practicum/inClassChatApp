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
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "saveCourseSegue" {
            
            if (CurrentUser.sharedInstance.checkForDuplicates(self.courseField.text)) {
                
                let alert = UIAlertView()
                alert.title = "Duplicate Class"
                alert.message = "You already have this class"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
            
            //Check if text is entered
            else if (self.courseField.text.isEmpty) {
                
                let alert = UIAlertView()
                alert.title = "No Text"
                alert.message = "Please write the class name"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
            
            else if (self.descriptionField.text.isEmpty) {
                
                let alert = UIAlertView()
                alert.title = "No Text"
                alert.message = "Please write a brief description of the class"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
            
        }
        // by default, transition
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "saveCourseSegue") {
            var flag = CourseStore.sharedInstance.findCourseIndex(self.courseField.text)
            if (flag == -1) {
                let course = Course(title: courseField.text, description: descriptionField.text)
                CurrentUser.sharedInstance.user.CourseList.append(course)
                CourseStore.sharedInstance.add(course)
            } else {
                CurrentUser.sharedInstance.user.CourseList.append(CourseStore.sharedInstance.get(flag))
            }
        }
    }
}