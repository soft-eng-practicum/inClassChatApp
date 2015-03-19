//
//  DiscussionViewController.swift
//  ClassChat
//
//  Created by Jake on 3/18/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

class DiscussionViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var commentTable: UITableView!
    var selectedQuestion: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = selectedQuestion.question
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedQuestion.commentList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var Cell = self.tableView.dequeueReusableCellWithIdentifier("ClassCell", forIndexPath: indexPath) as UITableViewCell
        Cell.textLabel?.text = ClassTableArray[indexPath.row].title
        Cell.detailTextLabel?.text = ClassTableArray[indexPath.row].description
        
        return Cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}