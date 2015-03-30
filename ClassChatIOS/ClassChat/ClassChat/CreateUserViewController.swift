//
//  CreateUserViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/12/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var warningLabel = UILabel()
    @IBOutlet weak var newUserNameField: UITextField!
    @IBOutlet weak var newPasswordField1: UITextField!
    @IBOutlet weak var newPasswordField2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.warningLabel?.hidden = true
        // Do any additional setup after loading the view.
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
    
    @IBAction func createUser(sender: UIButton) {
        if (newPasswordField1.text != newPasswordField2.text) {
            
            var alert = UIAlertView()
            alert.title = "Whoops!"
            alert.message = "Passwords don't match"
            alert.addButtonWithTitle("Ok")
            alert.show()
            
        } else {
            
            var backend:Backend = Backend()
        
            func onSuccess(credentials:NSDictionary) {
                print(credentials)
                performSegueWithIdentifier("SaveAndDismiss", sender: self)
            }
    
            backend.createUser(firstNameField.text, lastName: lastNameField.text, email: newUserNameField.text, password: newPasswordField1.text, onSuccess: onSuccess)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    }
}
