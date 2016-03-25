//
//  PendulumTests.swift
//  PendulumTests
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import XCTest
@testable import Pendulum

class PendulumTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testStart() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		
		while stopwatch.timePassed < 1 {}
		XCTAssert(stopwatch.isActive, "Should be active and running")
		XCTAssert(stopwatch.startDate != nil, "Should not be nil")
		XCTAssert(stopwatch.timePassed > 1, "Should be running already")
		
	}
	
	func testStop() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		stopwatch.stop()
		
		XCTAssert(stopwatch.isActive == false, "Should not be active")
		XCTAssert(stopwatch.startDate == nil, "Date should be nil")
		XCTAssert(stopwatch.timePassed == 0, "No time interval should be present")
	}
	
	func testStartIfPreviouslyRunning() {
		let stopwatch = PendulumStopwatch()
		stopwatch.continueIfPreviouslyRunning()
		XCTAssert(stopwatch.isActive, "Should not be active!")
		
//		stopwatch.start()
//		stopwatch.startIfPreviouslyRunning()
//		XCTAssert(stopwatch.isActive, "Should be active as it was created")
		
		stopwatch.stop()
		XCTAssert(stopwatch.isActive == false, "Should not be active after stop!")
	}
	
	func testPause() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		
		while stopwatch.timePassed < 1 {}
		stopwatch.pause()
		
		XCTAssert(stopwatch.isPaused, "isPaused should be true")
		XCTAssert(stopwatch.startDate == nil, "Start date should be nil")
		XCTAssert(stopwatch.timePassed > 0, "Time passed should be greater than 0")
		XCTAssert(stopwatch.timePassedWhileOnPause > 0, "Time passed while on pause should be greater than 0")
	}
	
	func testContinuity() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		let startTime = NSUserDefaults.standardUserDefaults().objectForKey("pendulumStartTime") as! NSDate!
		
		XCTAssert(startTime != nil, "pendulumStartTime should not be nil")
		XCTAssert(stopwatch.isActive, "Should be active and running")
		XCTAssert(stopwatch.startDate != nil, "Start date should not be nil")
		while stopwatch.timePassed < 1 {}
		XCTAssert(stopwatch.timePassed > 1, "Should be running already")
		
		while stopwatch.timePassed < 10 {}
		XCTAssert(NSDate().timeIntervalSinceDate(startTime) > 10, "Should be more than 10")
		
	}
	
	func testIsActive() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		
		XCTAssert(stopwatch.isActive, "Should be active and running")
		XCTAssert(stopwatch.startDate != nil, "Should not be nil")
		XCTAssert(stopwatch.timePassed > 0, "Should be greater than 0, as it was running for 0.2 milliseconds")
	}
	
	
	
	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct results.
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measureBlock {
			// Put the code you want to measure the time of here.
		}
	}
	
}
