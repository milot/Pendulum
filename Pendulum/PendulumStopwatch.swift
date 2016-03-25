//
//  Stopwatch.swift
//  Pendulum
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import Foundation

public class PendulumStopwatch: NSObject {
	public internal(set) var startDate: NSDate?
	public internal(set) var isPaused: Bool = false
	
	internal var timer: NSTimer?
	internal var timePassedWhileOnPause: NSTimeInterval!
	
	public override init() {
		super.init()
		
		timePassedWhileOnPause = 0
	}
	
	private func startRunningFrom(offset offset: NSTimeInterval) {
		timePassedWhileOnPause = isPaused ? timePassedWhileOnPause + offset : offset
		startDate = NSDate()
		create()
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
			NSUserDefaults.standardUserDefaults().setObject(startDate, forKey:"pendulumStartTime")
		}
	}
	
	public func stop() {
		destroy()
		isPaused = false
		timePassedWhileOnPause = 0
		startDate = nil
		NSUserDefaults.standardUserDefaults().setObject(nil, forKey:"pendulumStartTime")
	}
	
	public func pause() {
		destroy()		
		timePassedWhileOnPause = timePassed
		startDate = nil
		isPaused = true
	}
	
	public weak var delegate: PendulumDelegate? {
		didSet {
			if isActive {
				create()
				
				// re-create timer
				if oldValue == nil && delegate != nil {
					create()
					
					// destroy if no delegate present
				} else if delegate == nil {
					destroy()
				}
			}
		}
	}
	
	public var timePassed: NSTimeInterval {
		var currentTimeInterval: NSTimeInterval = 0
		
		if let startDate = self.startDate {
			currentTimeInterval = NSDate().timeIntervalSinceDate(startDate)
		}
		
		return timePassedWhileOnPause + currentTimeInterval
	}
	
	public var isActive: Bool {
		let startTime = NSUserDefaults.standardUserDefaults().objectForKey("pendulumStartTime") as! NSDate!
		return startTime != nil
	}
	
	public var isStopped: Bool {
		return !isActive && timePassedWhileOnPause == 0
	}
	
	public func refreshTriggered() {
		delegate?.stopwatchDidRefresh(self)
	}
	
	private func create() {
		destroy()
		
		guard delegate != nil else {
			return
		}
		
		if let refreshInterval = delegate?.refreshInterval(self) {
			let _timer = NSTimer(timeInterval: refreshInterval, target: self, selector: #selector(refreshTriggered), userInfo: nil, repeats: true)
			timer = _timer
			NSRunLoop.mainRunLoop().addTimer(_timer, forMode: NSRunLoopCommonModes)
		}
	}
	
	private func destroy() {
		timer?.invalidate()
		timer = nil
	}
}