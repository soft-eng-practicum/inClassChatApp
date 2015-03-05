//
//  DismissSegue.swift
//  ClassChat
//
//  Created by Jake on 3/4/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit

//Dismmisses windows

@objc(DismissSegue) class DismissSegue: UIStoryboardSegue {
    
    override func perform() {
        if let controller = sourceViewController.presentingViewController? {
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
