# Pendulum

<p align="center">
    <img src="https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat" alt="Platform: iOS 8+"/>
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift2-compatible-4BC51D.svg?style=flat" alt="Language: Swift 2" /></a></a>
     <br><br>
</p>

## Introduction

Pendulum is a small stopwatch framework that implements a little neat feature for a stopwatch timer on iOS.

The problem on iOS is that you don't have access to an NSTimer that runs in the background, all you get is 3 minutes of running timer until the app is killed by the OS. Pendulum stores the start time on NSUserDefaults and when you re-open the app it calculates time between current time and stored time in order to continue running where it left off.

#####Usage

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
