 //
//  ClassChatTestTests.swift
//  ClassChatTestTests
//
//  Created by Jake on 3/11/15.
//  Copyright (c) 2015 Jake. All rights reserved.
//

import UIKit
import XCTest
import ClassChat

public class ClassChatTestTests: XCTestCase {
    
    override public func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override public func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    public func testViewCreateUser() {
        let cu = CreateUserViewController()
        XCTAssertNotNil(cu.view, "View did not load")
    }
    public func testViewAddCourse() {
        let ac = AddCourseViewController()
        XCTAssertNotNil(ac.view, "View did not load")
    }
    public func testViewAddQuestion() {
        let aq = AddQuestionViewController()
        XCTAssertNotNil(aq.view, "View did not load")
    }
    public func testViewAddComment() {
        let ac2 = AddCommentViewController()
        XCTAssertNotNil(ac2.view, "View did not load")
    }
    public func testViewLogin() {
        let l = LoginViewController()
        XCTAssertNotNil(l.view, "View did not load")
    }
    public func testViewClasses() {
        let c = ClassesViewController()
        XCTAssertNotNil(c.view, "View did not load")
    }
    public func testViewQuestion() {
        let q = QuestionViewController()
        XCTAssertNotNil(q.view, "View did not load")
    }
    public func testViewCDiscussion() {
        let d = DiscussionViewController()
        XCTAssertNotNil(d.view, "View did not load")
    }
  
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
