//
//  PendulumObserver.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

@testable import Pendulum

class PendulumObserver: PendulumDelegate {
	
	
	func pendulumRefreshInterval(stopwatch: PendulumStopwatch) -> NSTimeInterval {
		return 0.3
	}
	
	func pendulumRefreshed(stopwatch: PendulumStopwatch) {
		print("Refreshed")
	}
}