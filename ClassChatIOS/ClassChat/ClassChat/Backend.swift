//
//  Backend.swift
//  ClassChat
//
//  Created by Jake on 3/19/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import Foundation
import UIKit

class Backend {
    
    
    init() {
        
    }
    
    func createUser(firstName:String, lastName:String, email:String, password:String, onSuccess:(NSDictionary)->()) {
        
        func responseReceived(response:NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error:Bool! = response["error"] as Bool
                
                if (error!) {
                    var errorMessage:String! = response["error_message"] as String
                   
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                } else {
                    var data:NSDictionary = response["data"] as NSDictionary
                    onSuccess(data)
                }
            }
        }
        
        request("http://jakemor.com/classchat_backend/createUser/email=" + email + "/first_name=" + firstName + "/last_name=" + lastName + "/password=" + password, callback: responseReceived)
    }
    
    func login(email:String, password:String, onSuccess:(NSDictionary)->()) {
        
        func responseReceived(response:NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error:Bool! = response["error"] as Bool
                
                if (error!) {
                    var errorMessage:String! = response["error_message"] as String
                    
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                } else {
                    var data:NSDictionary = response["data"] as NSDictionary
                    onSuccess(data)
                }
            }
        }
        
        request("http://jakemor.com/classchat_backend/login/email=" + email + "/password=" + password, callback: responseReceived)
    }
    
    
    func request(url:String, callback:(NSDictionary)->()){
        
        var nsURL = NSURL(string: url)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL) {
            
            (data,response,error) in

            var error:NSError?
            var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary!
            callback(response)
        }
        task.resume()
    }
}