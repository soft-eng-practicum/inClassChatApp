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
    
    func getQuestionAnswers(question_id: Int, onSuccess:(NSArray)->()) {
        
        func responseReceived(response: NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error: Bool! = response["error"] as Bool
                
                if (error!) {
                    
                    var errorMessage: String! = response["error_message"] as String
                    
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                } else {                    
                    var data:NSArray! = response["data"] as NSArray
                    onSuccess(data)
                }
            }
        }
        
        request("http://jakemor.com/classchat_backend/getQuestionAnswers/question_id=\(question_id)", callback: responseReceived)
    }
    
    func getCourseQuestions(course_id: Int, onSuccess:(NSArray)->()) {
        
        func responseReceived(response: NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error: Bool! = response["error"] as Bool
                
                if (error!) {
                    
                    var errorMessage: String! = response["error_message"] as String
                    
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                } else {
                    var data:NSArray! = response["data"] as NSArray
                    onSuccess(data)
                }
            }
        }
        
        request("http://jakemor.com/classchat_backend/getCourseQuestions/course_id=\(course_id)", callback: responseReceived)
    }
    
    func getUserCourses(user_id: Int, onSuccess:(NSArray)->()) {
        
        func responseReceived(response: NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error: Bool! = response["error"] as Bool
                
                if (error!) {
                    
                    var errorMessage: String! = response["error_message"] as String
                    
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                } else {
                    var data:NSArray! = response["data"] as NSArray
                    onSuccess(data)
                }
            }
        }
        
        request("http://jakemor.com/classchat_backend/getUserCourses/user_id=\(user_id)", callback: responseReceived)
    }
    
    func  postQuestion(user_id: Int, course_id: Int, question: String, onSuccess:()->()) {
        
        func responseReceived(response: NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error: Bool! = response["error"] as Bool
                
                if (error!) {
                    
                    var errorMessage: String! = response["error_message"] as String
                    
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                } else {
                    onSuccess()
                }
            }
        }
        
        let encoded:String! = question.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        request("http://jakemor.com/classchat_backend/postQuestion/user_id=\(user_id)/course_id=\(course_id)/question=" + encoded, callback: responseReceived)
        
    }
    
    
    func postAnswer(user_id: Int, question_id: Int, answer: String, onSuccess:()->()) {
        
        func responseReceived(response: NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error: Bool! = response["error"] as Bool
                
                if (error!) {
                    
                    var errorMessage: String! = response["error_message"] as String
                    
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                    
                } else {                    
                    onSuccess()
                }
            }
        }
        
        let encoded:String! = answer.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        
        request("http://jakemor.com/classchat_backend/postAnswer/user_id=\(user_id)/question_id=\(question_id)/answer=" + encoded, callback: responseReceived)
        
    }
    
    func  enrollUserInCourse(user_id: Int, course_name: String, onSuccess:(NSDictionary)->()) {
        
        func responseReceived(response: NSDictionary!) -> () {
            dispatch_async(dispatch_get_main_queue()) {
                var error: Bool! = response["error"] as Bool
                
                if (error!) {
                    
                    var errorMessage: String! = response["error_message"] as String
                    
                    let alert = UIAlertView()
                    alert.title = "Whoops!"
                    alert.message = errorMessage
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                
                } else {
                    var data: NSDictionary! = response["data"] as NSDictionary
                    onSuccess(data)
                }
            }
        }
        
        request("http://jakemor.com/classchat_backend/enrollUserInCourse/user_id=\(user_id)/course_name=" + course_name, callback: responseReceived)
        
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
            
            let raw = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            println("====RAW RESPONSE====")
            println(raw)
            println()
            
            if (response == nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertView()
                    alert.title = "500"
                    alert.message = "We've encountered an internal server error. Please try again in bit."
                    alert.addButtonWithTitle("Ok")
                    alert.show()
                }
            } else {
                callback(response)
            }
            
            
        }
        task.resume()
    }
}