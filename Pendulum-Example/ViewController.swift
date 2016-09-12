//
//  ViewController.swift
//  Pendulum-Example
//
//  Created by Milot Shala on 3/24/16.
//  Copyright © 2016 Milot Shala. All rights reserved.
//

import UIKit
import Pendulum
import ChameleonFramework

class ViewController: UIViewController, PendulumDelegate {
	public func pendulumRefreshInterval(_ stopwatch: PendulumStopwatch) -> TimeInterval {
		return 1
	}

	public func pendulumRefreshed(_ stopwatch: PendulumStopwatch) {
		timerLabel.text = timeStringFull(stopwatch.timePassedSince)
	}

	@IBOutlet weak var topTimerView: UIView!
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var startStopButton: UIButton!
	var stopwatch = PendulumStopwatch()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		stopwatch.delegate = self
		
		stopwatch.continueIfPreviouslyRunning()
		
		setupUI()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		if stopwatch.isActive {
			animateBorderIn(startStopButton)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupUI() {
		self.view.backgroundColor = GradientColor(.topToBottom, frame: self.view.frame, colors: [UIColor(red:0.19, green:0.20, blue:0.22, alpha:1.00), UIColor(red:0.20, green:0.22, blue:0.24, alpha:1.00)])
		
		topTimerView.backgroundColor = GradientColor(.topToBottom, frame: self.view.frame, colors: [UIColor(red:0.16, green:0.17, blue:0.18, alpha:1.00), UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)])
		
		timerLabel.font = UIFont(name: "Exo2-Regular", size: 38)
		
		startStopButton.titleLabel?.font = UIFont(name: "Exo2-Regular", size: 18)
		startStopButton.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
		startStopButton.clipsToBounds = true;
		startStopButton.layer.cornerRadius = startStopButton.frame.size.width/2
		startStopButton.layer.borderColor = UIColor(hexString: "#fc4a4e").cgColor
		startStopButton.layer.borderWidth = 0
		
		
	}
	
	
	func animateBorderIn(_ view: UIView) {
		if let button = view as? UIButton {
			button.setTitle("Stop", for: UIControlState())
		}
		
		let color:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
		color.fromValue = UIColor(hexString: "#fc4a4e").cgColor
		color.toValue = UIColor(hexString: "#fc4a4e").cgColor
		
		let Width:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
		Width.fromValue = 0
		Width.toValue = 1
		Width.duration = 0.5
		view.layer.borderWidth = 1
		
		let both:CAAnimationGroup = CAAnimationGroup()
		both.duration = 0.7
		both.animations = [color,Width]
		both.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
		
		view.layer.add(both, forKey: "color and Width")
	}
	
	func animateBorderOutOf(_ view: UIView) {
		if let button = view as? UIButton {
			button.setTitle("Start", for: UIControlState())
		}
		
		let color:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
		color.fromValue = UIColor(hexString: "#fc4a4e").cgColor
		color.toValue = UIColor(hexString: "#fc4a4e").cgColor
		
		let width:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
		
		if view.layer.borderWidth > 0 {
			width.fromValue = 1
		} else {
			width.fromValue = 0
		}
		width.toValue = 0
		width.duration = 0.5
		view.layer.borderWidth = 0
		
		let both:CAAnimationGroup = CAAnimationGroup()
		both.duration = 0.7
		both.animations = [color,width]
		both.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		
		view.layer.add(both, forKey: "color and Width")
	}
	
	func timeStringFull(_ interval:TimeInterval) -> String {
		let interval = Int(interval)
		let seconds = interval % 60
		let minutes = (interval / 60) % 60
		let hours = (interval / 3600)
		return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
	}
	
	@IBAction func startStopButtonTapped(_ sender: AnyObject) {
		if !stopwatch.isActive {
			stopwatch.start()
			animateBorderIn(startStopButton)
		} else {
			stopwatch.stop()
			animateBorderOutOf(startStopButton)
		}
	}
	
}

