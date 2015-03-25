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

        let name:String! = user["email"] as String
        let firstName:String! = user["first_name"] as String
        let lastName:String! = user["last_name"] as String
//        let school_id: ? = user["school_id"]
//        let user_id:AnyObject? = user["id"]
//        print(user_id! as? String)
        let user = User(name: name, password: name, firstName: firstName, lastName: lastName, school_id: "1", user_id: "37")
        CurrentUser.sharedInstance.assignCurrentUser(user)
        performSegueWithIdentifier("loginSegue", sender: self)
        
    }
    
    @IBAction func loginNow(sender: AnyObject) {
        
        var backend:Backend = Backend()
        
        backend.login(UsernameField.text, password: PasswordField.text, onSuccess: loggedIn)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "loginSegue") {
            print(CurrentUser.sharedInstance.user.user_id)
        }
    }
}
