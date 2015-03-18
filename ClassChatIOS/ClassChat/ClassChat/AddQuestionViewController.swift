//
//  AddQuestionViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/15/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet weak var QuestionField: UITextField!
    var selectedCourse: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "saveQuestionSegue" {
                
                //Check if text is entered
            if (self.QuestionField.text.isEmpty) {
                
                let alert = UIAlertView()
                alert.title = "No Text"
                alert.message = "Please type a question"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
            
        }
        // by default, transition
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "saveQuestionSegue") {
            self.selectedCourse.questionList.append(Question(question: QuestionField.text))
//            var navigationController = segue.destinationViewController as UINavigationController
            var DestinationViewController = segue.destinationViewController as QuestionViewController
            DestinationViewController.selectedCourse = self.selectedCourse
        }
        
        if (segue.identifier == "cancelNewQuestionSegue") {
//            var navigationController = segue.destinationViewController as UINavigationController
            var DestinationViewController = segue.destinationViewController as QuestionViewController
            DestinationViewController.selectedCourse = self.selectedCourse
        }
    }
}