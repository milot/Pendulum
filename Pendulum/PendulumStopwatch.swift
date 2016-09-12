//
//  Stopwatch.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import Foundation

open class PendulumStopwatch: NSObject {
	open internal(set) var startTime: Date?
	open internal(set) var isPaused: Bool = false
	internal var timer: Timer?
	internal var timePassedWhileOnPause: TimeInterval!
	
	public override init() {
		super.init()
		
		timePassedWhileOnPause = 0
	}
	
	fileprivate func startRunningFrom(offset: TimeInterval) {
		timePassedWhileOnPause = isPaused ? timePassedWhileOnPause + offset : offset
		startTime = Date()
		initiateTimer()
		isPaused = false
	}
	
	open func continueIfPreviouslyRunning() {
		let startTime = UserDefaults.standard.object(forKey: "pendulumStartTime") as! Date!
		if (startTime != nil) {
			let timeIntervalBetween = Date().timeIntervalSince(startTime!)
			startRunningFrom(offset: timeIntervalBetween)
		}
	}
	
	open func start() {
		let startTime = UserDefaults.standard.object(forKey: "pendulumStartTime") as! Date!
		if (startTime != nil) {
			let timeIntervalBetween = Date().timeIntervalSince(startTime!)
			startRunningFrom(offset: timeIntervalBetween)
		} else {
			startRunningFrom(offset: 0)
			UserDefaults.standard.set(self.startTime, forKey:"pendulumStartTime")
		}
	}
	
	open func stop() {
		invalidateTimer()
		isPaused = false
		timePassedWhileOnPause = 0
		startTime = nil
		UserDefaults.standard.set(nil, forKey:"pendulumStartTime")
	}
	
	open func pause() {
		invalidateTimer()		
		timePassedWhileOnPause = timePassedSince
		startTime = nil
		isPaused = true
	}
	
	open func timerRefreshTriggered() {
		delegate?.pendulumRefreshed(self)
	}
	
	fileprivate func initiateTimer() {
		invalidateTimer()
		
		guard delegate != nil else {
			return
		}
		
		if let refreshInterval = delegate?.pendulumRefreshInterval(self) {
			let _timer = Timer(timeInterval: refreshInterval, target: self, selector: #selector(timerRefreshTriggered), userInfo: nil, repeats: true)
			timer = _timer
			RunLoop.main.add(_timer, forMode: RunLoopMode.commonModes)
		}
	}
	
	fileprivate func invalidateTimer() {
		timer?.invalidate()
		timer = nil
	}
	
	open var timePassedSince: TimeInterval {
		var currentTimeInterval: TimeInterval = 0
		
		if let startDate = self.startTime {
			currentTimeInterval = Date().timeIntervalSince(startDate)
		}
		
		return timePassedWhileOnPause + currentTimeInterval
	}
	
	open var isActive: Bool {
		return self.startTime != nil
	}
	
	open var isStopped: Bool {
		
		return !isActive && timePassedWhileOnPause == 0
	}
	
	open weak var delegate: PendulumDelegate? {
		didSet {
			if isActive {
				initiateTimer()
				
				// re-create timer
				if oldValue == nil && delegate != nil {
					initiateTimer()
					
					// destroy if no delegate present
				} else if delegate == nil {
					invalidateTimer()
				}
			}
		}
	}
}
