# Pendulum
Pendulum is a stopwatch framework that implements a little neat feature for a stopwatch timer on iOS.

The problem on iOS is that you don't have access to a timer that runs on background if the app is not active, while working on a project and in need of this feature I had to add something like that to my already existing Stopwatch class that I've been using, what I am doing on the Stopwatch is that I record the time when the Stopwatch started and once the app runs again it compares the current time with the previously stored time and continues to run from that NSTimeInterval.
