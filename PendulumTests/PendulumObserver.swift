//
//  PendulumObserver.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

@testable import Pendulum

class PendulumObserver: PendulumDelegate {
	var refreshCounter = 0
	
	func refreshInterval(stopwatch: PendulumStopwatch) -> NSTimeInterval {
		return 0.3
	}
	
	func stopwatchDidRefresh(stopwatch: PendulumStopwatch) {
		refreshCounter += 1
		print("Refresh Count: \(refreshCounter)")
	}
}