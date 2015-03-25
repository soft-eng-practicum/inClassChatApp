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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ClassTableArray = CurrentUser.sharedInstance.user.CourseList
        
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
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            ClassTableArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    @IBAction func unwindAddCourseView(segue: UIStoryboardSegue) {
        print("sup")
    }
    
}

