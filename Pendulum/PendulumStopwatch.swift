//
//  Stopwatch.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import Foundation

public class PendulumStopwatch: NSObject {
	public internal(set) var startTime: NSDate?
	public internal(set) var isPaused: Bool = false
	internal var timer: NSTimer?
	internal var timePassedWhileOnPause: NSTimeInterval!
	
	public override init() {
		super.init()
		
		timePassedWhileOnPause = 0
	}
	
	private func startRunningFrom(offset offset: NSTimeInterval) {
		timePassedWhileOnPause = isPaused ? timePassedWhileOnPause + offset : offset
		startTime = NSDate()
		initiateTimer()
		isPaused = false
	}
	
	public func continueIfPreviouslyRunning() {
		let startTime = NSUserDefaults.standardUserDefaults().objectForKey("pendulumStartTime") as! NSDate!
		if (startTime != nil) {
			let timeIntervalBetween = NSDate().timeIntervalSinceDate(startTime)
			startRunningFrom(offset: timeIntervalBetween)
		}
	}
	
	public func start() {
		let startTime = NSUserDefaults.standardUserDefaults().objectForKey("pendulumStartTime") as! NSDate!
		if (startTime != nil) {
			let timeIntervalBetween = NSDate().timeIntervalSinceDate(startTime)
			startRunningFrom(offset: timeIntervalBetween)
		} else {
			startRunningFrom(offset: 0)
			NSUserDefaults.standardUserDefaults().setObject(self.startTime, forKey:"pendulumStartTime")
		}
	}
	
	public func stop() {
		invalidateTimer()
		isPaused = false
		timePassedWhileOnPause = 0
		startTime = nil
		NSUserDefaults.standardUserDefaults().setObject(nil, forKey:"pendulumStartTime")
	}
	
	public func pause() {
		invalidateTimer()		
		timePassedWhileOnPause = timePassedSince
		startTime = nil
		isPaused = true
	}
	
	public func timerRefreshTriggered() {
		delegate?.pendulumRefreshed(self)
	}
	
	private func initiateTimer() {
		invalidateTimer()
		
		guard delegate != nil else {
			return
		}
		
		if let refreshInterval = delegate?.pendulumRefreshInterval(self) {
			let _timer = NSTimer(timeInterval: refreshInterval, target: self, selector: #selector(timerRefreshTriggered), userInfo: nil, repeats: true)
			timer = _timer
			NSRunLoop.mainRunLoop().addTimer(_timer, forMode: NSRunLoopCommonModes)
		}
	}
	
	private func invalidateTimer() {
		timer?.invalidate()
		timer = nil
	}
	
	public var timePassedSince: NSTimeInterval {
		var currentTimeInterval: NSTimeInterval = 0
		
		if let startDate = self.startTime {
			currentTimeInterval = NSDate().timeIntervalSinceDate(startDate)
		}
		
		return timePassedWhileOnPause + currentTimeInterval
	}
	
	public var isActive: Bool {
		return self.startTime != nil
	}
	
	public var isStopped: Bool {
		
		return !isActive && timePassedWhileOnPause == 0
	}
	
	public weak var delegate: PendulumDelegate? {
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