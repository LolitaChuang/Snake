//
//  SnakeTests.swift
//  SnakeTests
//
//  Created by Lolita Chuang on 2017/2/3.
//  Copyright © 2017年 Child Woman. All rights reserved.
//

import XCTest
@testable import Snake

class SnakeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
    func testExtend() {
        let testSnake = Snake(head:Snake.Position(x:125, y:125), border:Snake.Position(x:320, y:480))
        
        XCTAssert(testSnake.length==2, "initial length should be 2")
        testSnake.extend()
        XCTAssert(testSnake.length==4, "extend length to 4 but fail")
        
    }
}
