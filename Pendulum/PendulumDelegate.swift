//
//  PendulumDelegate.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import Foundation

public protocol PendulumDelegate: class {
	func pendulumRefreshInterval(stopwatch: PendulumStopwatch) -> NSTimeInterval
	func pendulumRefreshed(stopwatch: PendulumStopwatch)
}