//
//  DiscussionViewController.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class DiscussionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var commentTable: UITableView!
    var selectedQuestion: Question!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = selectedQuestion.content
        self.commentTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "commentCell")
        loadCommentTable()
//        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("loadCommentTable"), forControlEvents: UIControlEvents.ValueChanged)
        commentTable.addSubview(refreshControl)
    }
    
    func loadCommentTable() {
    
        func onSuccess(questionAnswers: NSArray)->() {
            
            selectedQuestion.commentList = [Comment]()
    
            for answer in questionAnswers {
                
                
                var answer:String! = answer["content"] as String
                var comment = Comment(text: answer)
                selectedQuestion.commentList.append(comment)
            }
            self.commentTable.reloadData()
            refreshControl.endRefreshing()
        }
        
        var backend:Backend = Backend()
        
        backend.getQuestionAnswers(selectedQuestion.id, onSuccess: onSuccess)
        
    
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedQuestion.commentList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.commentTable.dequeueReusableCellWithIdentifier("commentCell") as UITableViewCell
        cell.textLabel?.text = selectedQuestion.commentList[indexPath.row].text
        return cell
    }
    
    @IBAction func unwindAddCommentView(segue: UIStoryboardSegue) {
        if let ACV = segue.sourceViewController as? AddCommentViewController {
            self.selectedQuestion = ACV.selectedQuestion
        }
        
        
    }
    
    //selected cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "addCommentSegue") {
            var DestinationViewController = segue.destinationViewController as AddCommentViewController
            DestinationViewController.selectedQuestion = self.selectedQuestion
        }
    }
    
    
}