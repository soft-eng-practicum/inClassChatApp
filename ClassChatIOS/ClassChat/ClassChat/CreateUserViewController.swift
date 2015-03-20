//
//  CreateUserViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/12/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var warningLabel = UILabel()
    @IBOutlet weak var newUserNameField: UITextField!
    @IBOutlet weak var newPasswordField1: UITextField!
    @IBOutlet weak var newPasswordField2: UITextField!
    var flag = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.warningLabel?.hidden = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createUser(sender: AnyObject) {
        
        var backend:Backend = Backend()
        
        func onSuccess(credentials:NSDictionary) {
            print(credentials)
            performSegueWithIdentifier("SaveAndDismiss", sender: self)
        }
    
        backend.createUser(firstNameField.text, lastName: lastNameField.text, email: newUserNameField.text, password: newPasswordField1.text, onSuccess: onSuccess)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "SaveAndDismiss") {
            let newUser = User(name: newUserNameField.text, password: newPasswordField1.text, firstName: firstNameField.text, lastName: lastNameField.text)
            UserStore.sharedInstance.add(newUser)
        }
    }
}
