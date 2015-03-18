//
//  LoginViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/12/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if identifier == "loginSegue" {
            
            //Check if text is entered
            if (self.UsernameField.text.isEmpty) {
                
                let alert = UIAlertView()
                alert.title = "No Text"
                alert.message = "Please Enter Username In The Box"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
                
            //Check if doesn't exist
            else if (UserStore.sharedInstance.findUserNameIndex(self.UsernameField.text) == -1) {
                
                let alert = UIAlertView()
                alert.title = "Username Does Not Exist"
                alert.message = "Please Enter New Username In The Box Or Create New Account"
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
        if (segue.identifier == "loginSegue") {
            var i = UserStore.sharedInstance.findUserNameIndex(self.UsernameField.text)
            CurrentUser.sharedInstance.assignCurrentUser(UserStore.sharedInstance.get(i))
        }
    }
}
