//
//  CreateUserViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/12/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var warningLabel = UILabel()
    @IBOutlet weak var newUserNameField: UITextField!
    @IBOutlet weak var newPasswordField1: UITextField!
    @IBOutlet weak var newPasswordField2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.warningLabel?.hidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "SaveAndDismiss" {

            //Check if text is entered
            if (self.newUserNameField.text.isEmpty) {
                
                let alert = UIAlertView()
                alert.title = "No Text"
                alert.message = "Please Enter Username In The Box"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
            
            //Check if username already exists
            else if (UserStore.sharedInstance.findUserNameIndex(self.newUserNameField.text) != -1) {
                
                let alert = UIAlertView()
                alert.title = "Username Already Exists"
                alert.message = "Please Enter New Username In The Box"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
                
            else {
                return true
            }
            
        }
        
        // by default, transition
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "SaveAndDismiss") {
            let newUser = User(name: newUserNameField.text, password: newPasswordField1.text)
            UserStore.sharedInstance.add(newUser)
        }
    }
}
