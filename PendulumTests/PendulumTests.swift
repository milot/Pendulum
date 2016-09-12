//
//  PendulumTests.swift
//  PendulumTests
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import XCTest
import Pendulum

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
		
		while stopwatch.timePassedSince < 1 {}
		XCTAssert(stopwatch.isActive, "Should be active and running")
		XCTAssert(stopwatch.startTime != nil, "Should not be nil")
		XCTAssert(stopwatch.timePassedSince > 1, "Should be running already")
		
	}
	
	func testStop() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		stopwatch.stop()
		
		XCTAssert(stopwatch.isActive == false, "Should not be active")
		XCTAssert(stopwatch.startTime == nil, "Date should be nil")
		XCTAssert(stopwatch.timePassedSince == 0, "No time interval should be present")
	}
	
	func testStartIfPreviouslyRunning() {
		let stopwatch = PendulumStopwatch()
		stopwatch.continueIfPreviouslyRunning()
		XCTAssert(stopwatch.isActive, "Should be active!")
		
		stopwatch.stop()
		XCTAssert(stopwatch.isActive == false, "Should not be active after stop!")
	}
	
	func testPause() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		
		while stopwatch.timePassedSince < 1 {}
		stopwatch.pause()
		
		XCTAssert(stopwatch.isPaused, "isPaused should be true")
		XCTAssert(stopwatch.startTime == nil, "Start date should be nil")
		XCTAssert(stopwatch.timePassedSince > 0, "Time passed should be greater than 0")
		XCTAssert(stopwatch.timePassedWhileOnPause > 0, "Time passed while on pause should be greater than 0")
	}
	
	func testContinuity() {
		let stopwatch = PendulumStopwatch()
		stopwatch.continueIfPreviouslyRunning()
		let startTime1 = UserDefaults.standard.object(forKey: "pendulumStartTime") as! Date!
		XCTAssert(startTime1 != nil, "pendulumStartTime should not be nil at this point")
		XCTAssert(stopwatch.isActive, "Active")
		
		while stopwatch.timePassedSince < 10 {}
		XCTAssert(stopwatch.timePassedSince > 10, "Should be running already")
		stopwatch.stop()
		
	}
	
	func testIsActive() {
		let stopwatch = PendulumStopwatch()
		stopwatch.start()
		
		XCTAssert(stopwatch.isActive, "Should be active and running")
		XCTAssert(stopwatch.startTime != nil, "Should not be nil")
		XCTAssert(stopwatch.timePassedSince > 0, "Should be greater than 0, as it was running for 0.2 milliseconds")
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
