# Pendulum

<p align="center">
    <img src="https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat" alt="Platform: iOS 8+"/>
    <img src="https://img.shields.io/badge/platform-tvOS%209%2B-blue.svg" alt="Platform: tvOS 9+"/>    
    <img src="https://img.shields.io/badge/platform-watchOS%202.2-blue.svg" alt="Platform: watchOS 2.2"/>        
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Language: Swift 3" /></a></a>
    <a href="https://github.com/milot/Pendulum/releases/tag/1.0.1"><img src="https://img.shields.io/badge/pod-v1.0.1-orange.svg" alt="CocoaPods compatible" /></a>
    <img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" />
     <br><br>
</p>

## Introduction

Pendulum is a small stopwatch framework that implements a little neat feature for a stopwatch timer on iOS, tvOS and watchOS.

The problem on iOS is that you don't have access to an NSTimer that runs in the background, all you get is 3 minutes of running timer until the app is killed by the OS. Pendulum stores the start time on NSUserDefaults and when you re-open the app it calculates time between current time and stored time in order to continue running where it left off.

## Installation

####CocoaPods Installation
Pendulum is available on [CocoaPods](http://cocoapods.org). Simply add the following to your project Podfile, and you'll be good to go.

``` ruby
use_frameworks!

pod 'Pendulum'
```

####Manual Installation

Simply copy the Pendulum.framework on your project and you're good to go.


## Usage

For more detailed usage, please check both PendulumTests and PendulumProtocolTests also there is a Pendulum-Example written in Swift.

For basic usage, please refer to the two examples below:

######Swift
``` swift
let stopwatch = PendulumStopwatch()
stopwatch.start()
```

######Objective-C
``` objective-c
PendulumStopwatch* stopwatch = [[PendulumStopwatch alloc] init];
[stopwatch start];
```

## Example app
######Running the app

In order to run the app, please run **pod install** first.


######Screenshot
Here's a screenshot of the example app that has been running for more than two hours:

<p align="center">
    <img src="http://i.imgur.com/lNACPKR.png" height="400" alt="Platform: iOS 8+"/>
</p>
