//
//  ViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/11/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class ClassesViewController: UITableViewController {
    
    var ClassTableArray = [Course]()
    var backend:Backend = Backend()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadClassTable()
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("loadClassTable"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    func loadClassTable() {
        
        func populateTable(userCourses: NSArray)->() {
            
            CurrentUser.sharedInstance.user.CourseList = [Course]()
            
            for course in userCourses {
                var course_id:Int! = course["id"] as Int
                var course_name:String! = course["name"] as String
                var description:String! = course["description"] as String
                CurrentUser.sharedInstance.user.CourseList.append(Course(title: course_name, description: description, course_id: course_id))
            }
            
            ClassTableArray = CurrentUser.sharedInstance.user.CourseList
            
            tableView.reloadData()
            refreshControl?.endRefreshing()
            
        }
        
        
        
        backend.getUserCourses(CurrentUser.sharedInstance.user.user_id, onSuccess: populateTable)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClassTableArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = self.tableView.dequeueReusableCellWithIdentifier("ClassCell", forIndexPath: indexPath) as UITableViewCell
        Cell.textLabel?.text = ClassTableArray[indexPath.row].title
        Cell.detailTextLabel?.text = ClassTableArray[indexPath.row].description
        
        return Cell
    }
    
    //Will eventually confirm with user if they want to log out
    override func shouldPerformSegueWithIdentifier(identifier: String!, sender: AnyObject!) -> Bool {
        if (identifier == "logoutSegue") {
            let alert = UIAlertView()
            alert.delegate = self
            alert.title = "Log Out"
            alert.message = "Are you sure?"
            alert.addButtonWithTitle("Yes")
            alert.addButtonWithTitle("No")
            alert.show()
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showQuestionSegue") {
            var indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow()!
            var DestinationViewController = segue.destinationViewController as QuestionViewController
            DestinationViewController.selectedCourse = ClassTableArray[indexPath.row]
        }
        
        if (segue.identifier == "logoutSegue") {
            
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func deleteCourse(selectedCourse: Course) {
        
        func onSuccess(response:NSDictionary) {
            println("deleted from server")
        }
        
        backend.dropUserFromCourse(CurrentUser.sharedInstance.user.user_id, course_name: selectedCourse.title, onSuccess: onSuccess)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            deleteCourse(ClassTableArray[indexPath.row])
            CurrentUser.sharedInstance.user.removeClassWithName(ClassTableArray[indexPath.row].title)
            ClassTableArray.removeAtIndex(indexPath.row)
            
            
            //TODO - remove user.courseList from index
            
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    @IBAction func unwindAddCourseView(segue: UIStoryboardSegue) {
        ClassTableArray = CurrentUser.sharedInstance.user.CourseList
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
}

