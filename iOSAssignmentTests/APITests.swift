//
//  APITests.swift
//  iOSAssignmentTests
//
//  Created by Tu (Callie) T. NGUYEN on 7/18/19.
//  Copyright © 2019 Tu (Callie) T. NGUYEN. All rights reserved.
//

import XCTest
@testable import iOSAssignment

class APITests: XCTestCase {
    
    private var apiServies : APIServices!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        apiServies = APIServices()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
    }

    func testTotalAmountOfUser() {
        
        let promise = expectation(description: "Status code: 200")
        
        APIServices.shared.fetchData { (data) in
            
            print("Test with case:          right")
            XCTAssertEqual(data?.count, 30, "Total amount of users api is right")
            
            print("Test with case:          wrong")
            XCTAssertNotEqual(data?.count, 3, "Total amount of users api is wrong")
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testFollowingAndFollowerOfUser() {
        let promise = expectation(description: "Status code: 200")
        let userID = 1
        
        APIServices.shared.getDetailUser(id: userID) { (data) in
            
            XCTAssertEqual(data?.followers, 21546, "number of follower is correct")
            
            XCTAssertEqual(data?.following, 11, "number of following is correct")
            
            
            XCTAssertNotEqual(data?.followers, 1, "number of follower is not correct")
            
            XCTAssertNotEqual(data?.following, 1, "number of following is not correct")
            
            promise.fulfill()
        }
        
        wait(for: [promise], timeout: 10)
    }
    
    func testABC() {
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
