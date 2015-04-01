//
//  LoginViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/12/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        buttonConstraint.constant = 0
//        UsernameField.becomeFirstResponder()
        
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                buttonConstraint.constant = keyboardHeight
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    
    func keyboardWillHide(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                buttonConstraint.constant = 0
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.view.layoutIfNeeded()
                })
            }
        }
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
    
    func loggedIn(user:NSDictionary)->() {

        let name:String! = user["email"] as String
        let firstName:String! = user["first_name"] as String
        let lastName:String! = user["last_name"] as String
        let school_id:String! = user["school_id"] as String
        let user_id:Int! = user["id"] as Int
        let user = User(name: name, password: name, firstName: firstName, lastName: lastName, school_id: school_id, user_id: user_id)
        CurrentUser.sharedInstance.assignCurrentUser(user)
        performSegueWithIdentifier("loginSegue", sender: self)
        
    }
    
    @IBAction func loginNow(sender: AnyObject) {
        
        var backend:Backend = Backend()
        
        backend.login(UsernameField.text, password: PasswordField.text, onSuccess: loggedIn)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

    }
}
