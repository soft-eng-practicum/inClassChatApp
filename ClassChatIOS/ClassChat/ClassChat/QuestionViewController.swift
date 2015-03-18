//
//  QuestionViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/11/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class QuestionViewController: UITableViewController {

    @IBOutlet weak var pageTitleItem: UINavigationItem!
    
    
    var QuestionArray = [Question]()
    
    var selectedCourse: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionArray = selectedCourse.questionList
        pageTitleItem.title = selectedCourse.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = QuestionArray[indexPath.row].question
        return cell
    }

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addQuestionSegue") {
            var navigationController = segue.destinationViewController as UINavigationController
            var DestinationViewController = navigationController.topViewController as AddQuestionViewController
            DestinationViewController.selectedCourse = self.selectedCourse
        }
    }


}
