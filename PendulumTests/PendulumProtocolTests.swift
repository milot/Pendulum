//
//  PendulumProtocolTests.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import XCTest
@testable import Pendulum

class StopwatchProcolTests: XCTestCase {
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testStopwatchCreation() {
		let stopwatch = PendulumStopwatch()
		let observer = PendulumObserver()
		
		stopwatch.delegate = observer
		
		XCTAssert(stopwatch.timer == nil, "Pendulum not running yet, should be nil")
		stopwatch.start()
		XCTAssert(stopwatch.timer != nil, "Pendulum is running, timer should start")
	}
	
}