//
//  QuestionViewController.swift
//  ClassChatTest
//
//  Created by Jake on 3/11/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class QuestionViewController: UITableViewController, UITableViewDataSource {

    @IBOutlet weak var pageTitleItem: UINavigationItem!
    
    var selectedCourse: Course!
    var pullRefresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitleItem.title = selectedCourse.title
        
        self.pullRefresh = UIRefreshControl()
        self.pullRefresh.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(pullRefresh)
        
    }

    func refresh(sender: AnyObject) {
        tableView.reloadData()
        self.pullRefresh.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCourse.questionList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = selectedCourse.questionList[indexPath.row].question
        return cell
    }

    @IBAction func unwindAddQuestionView(segue: UIStoryboardSegue) {
        if let ADQ = segue.sourceViewController as? AddQuestionViewController {
            self.selectedCourse = ADQ.selectedCourse
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addQuestionSegue") {
            var DestinationViewController = segue.destinationViewController as AddQuestionViewController
            DestinationViewController.selectedCourse = self.selectedCourse
        }
        
        if (segue.identifier == "discussionViewSegue") {
            var indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow()!
            var DestinationViewController = segue.destinationViewController as DiscussionViewController
            DestinationViewController.selectedQuestion = selectedCourse.questionList[indexPath.row]
        }
    }
}
