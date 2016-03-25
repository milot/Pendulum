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
	
	override func viewDidAppear(animated: Bool) {
		if stopwatch.isActive {
			animateBorderIn(startStopButton)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func setupUI() {
		self.view.backgroundColor = GradientColor(.TopToBottom, frame: self.view.frame, colors: [UIColor(red:0.19, green:0.20, blue:0.22, alpha:1.00), UIColor(red:0.20, green:0.22, blue:0.24, alpha:1.00)])
		
		topTimerView.backgroundColor = GradientColor(.TopToBottom, frame: self.view.frame, colors: [UIColor(red:0.16, green:0.17, blue:0.18, alpha:1.00), UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)])
		
		timerLabel.font = UIFont(name: "Exo2-Regular", size: 38)
		
		startStopButton.titleLabel?.font = UIFont(name: "Exo2-Regular", size: 18)
		startStopButton.backgroundColor = UIColor(red:0.15, green:0.15, blue:0.15, alpha:1.00)
		startStopButton.clipsToBounds = true;
		startStopButton.layer.cornerRadius = startStopButton.frame.size.width/2
		startStopButton.layer.borderColor = UIColor(hexString: "#fc4a4e").CGColor
		startStopButton.layer.borderWidth = 0
		
		
	}
	
	
	func animateBorderIn(view: UIView) {
		if let button = view as? UIButton {
			button.setTitle("Stop", forState: .Normal)
		}
		
		let color:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
		color.fromValue = UIColor(hexString: "#fc4a4e").CGColor
		color.toValue = UIColor(hexString: "#fc4a4e").CGColor
		
		let Width:CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
		Width.fromValue = 0
		Width.toValue = 1
		Width.duration = 0.5
		view.layer.borderWidth = 1
		
		let both:CAAnimationGroup = CAAnimationGroup()
		both.duration = 0.7
		both.animations = [color,Width]
		both.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
		
		view.layer.addAnimation(both, forKey: "color and Width")
	}
	
	func animateBorderOutOf(view: UIView) {
		if let button = view as? UIButton {
			button.setTitle("Start", forState: .Normal)
		}
		
		let color:CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
		color.fromValue = UIColor(hexString: "#fc4a4e").CGColor
		color.toValue = UIColor(hexString: "#fc4a4e").CGColor
		
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
		
		view.layer.addAnimation(both, forKey: "color and Width")
	}
	
	func timeStringFull(interval:NSTimeInterval) -> String {
		let interval = Int(interval)
		let seconds = interval % 60
		let minutes = (interval / 60) % 60
		let hours = (interval / 3600)
		return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
	}
	
	@IBAction func startStopButtonTapped(sender: AnyObject) {
		if !stopwatch.isActive {
			stopwatch.start()
			animateBorderIn(startStopButton)
		} else {
			stopwatch.stop()
			animateBorderOutOf(startStopButton)
		}
	}
	
	func refreshInterval(stopwatch: PendulumStopwatch) -> NSTimeInterval {
		return 1
	}
	
	func stopwatchDidRefresh(stopwatch: PendulumStopwatch) {
		timerLabel.text = timeStringFull(stopwatch.timePassed)
	}
	
}

