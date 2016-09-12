//
//  PendulumObserver.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

@testable import Pendulum

class PendulumObserver: PendulumDelegate {
	
	
	func pendulumRefreshInterval(_ stopwatch: PendulumStopwatch) -> TimeInterval {
		return 0.3
	}
	
	func pendulumRefreshed(_ stopwatch: PendulumStopwatch) {
		print("Refreshed")
	}
}
