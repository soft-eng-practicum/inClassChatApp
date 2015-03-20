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
    
    func loggedIn(user:NSDictionary)->() {
        
        print(user)
        
        let name:String! = user["email"] as String
        let firstName:String! = user["first_name"] as String
        let lastName:String! = user["last_name"] as String
        let school_id: Int! = user["school_id"] as Int
        
        let newUser = User(name: name, password: name, firstName: firstName, lastName: lastName, school_id: school_id)
        UserStore.sharedInstance.add(newUser)
        
        CurrentUser.sharedInstance.assignCurrentUser(newUser)        
        performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    @IBAction func loginNow(sender: AnyObject) {
        
        var backend:Backend = Backend()
        
        backend.login(UsernameField.text, password: PasswordField.text, onSuccess: loggedIn)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "loginSegue") {
//            var i = UserStore.sharedInstance.findUserNameIndex(self.UsernameField.text)
//            CurrentUser.sharedInstance.assignCurrentUser(UserStore.sharedInstance.get(i))
        }
    }
}
