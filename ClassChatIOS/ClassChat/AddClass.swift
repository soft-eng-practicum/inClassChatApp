//
//  AddClass.swift
//  ClassChat
//
//  Created by Jake on 3/4/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

//This is a subclass of UIViewController

class AddClass: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "DismissAndSave" {
            let newClass = Class(title: titleField.text, description: descriptionField.text)
            ClassStore.sharedInstance.add(newClass)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
