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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = selectedQuestion.content
        self.commentTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "commentCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedQuestion.commentList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.commentTable.dequeueReusableCellWithIdentifier("commentCell") as UITableViewCell
        cell.textLabel?.text = selectedQuestion.commentList[indexPath.row].text
        return cell
    }
    
    @IBAction func unwindAddQuestionView(segue: UIStoryboardSegue) {
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