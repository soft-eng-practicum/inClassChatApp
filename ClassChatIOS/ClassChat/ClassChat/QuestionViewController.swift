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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageTitleItem.title = selectedCourse.title
        loadQuestionTable()
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("loadQuestionTable"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    func loadQuestionTable() {
        
        func onSuccess(courseQuestions: NSArray)->() {
            
            selectedCourse.questionList = [Question]()
            
            for question in courseQuestions {
                
                var question_id:Int! = question["id"] as Int
                var content:String! = question["content"] as String
                var likes:Int! = question["likes"] as Int
                var user_id:String! = question["user_id"] as String
                
                var question = Question(content: content, id: question_id, user_id: user_id.toInt()!, likes: likes)
                
                selectedCourse.questionList.append(question)
            }
            
            tableView.reloadData()
            refreshControl?.endRefreshing()
            
        }
        
        var backend:Backend = Backend()
        
        backend.getCourseQuestions(selectedCourse.course_id, onSuccess: onSuccess)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedCourse.questionList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = selectedCourse.questionList[indexPath.row].content
        return cell
    }

    @IBAction func unwindAddQuestionView(segue: UIStoryboardSegue) {
        if let ADQ = segue.sourceViewController as? AddQuestionViewController {
            self.selectedCourse = ADQ.selectedCourse
        }
        loadQuestionTable()
    }
    

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
