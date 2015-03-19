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
    

    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var QuestionField: UITextField!
    
    var selectedCourse: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveQuestion(sender: AnyObject) {
        if (self.QuestionField.text.isEmpty) {
            let alert = UIAlertView()
            alert.title = "No Text"
            alert.message = "Please type a question"
            alert.addButtonWithTitle("Ok")
            alert.show()
        } else {
            self.selectedCourse.questionList.append(Question(question: QuestionField.text))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}