[![Version](http://cocoapod-badges.herokuapp.com/v/ios-time-synchronization/badge.png)]
[![Platform](http://cocoapod-badges.herokuapp.com/p/ios-time-synchronization/badge.png)]
[![License](http://cocoapod-badges.herokuapp.com/l/ios-time-synchronization/badge.png)]

## About this class

    iOS pod for time synchronization between iOS device and backend

    NSDate subclass to track and keep actual date even if wrong time & timezone setted on the device 
    
## Usage Example

    First you need to update interval between backend and device:

    [APMSynchronizedDate updateSynchronizationIntervalForCurrentServerDate:currentServerDate 
						      andCurrentDeviceDate:currentDeviceDate];
    
    Next you can create APMSynchronizedDate object with date from event from backend:

    APMSynchronizedDate *synchronizedDate = 
    [APMSynchronizedDate synchronizedDateFromServerDate:_eventFromServerDate_];

    or from date created on device:

    APMSynchronizedDate *synchronizedDate = 
    [APMSynchronizedDate synchronizedDateFromDeviceDate:_createdOnDeviceDate_];     

    To get converted date for local usage use -deviceDate method: 
    NSDate *localDate = [synchronizedDate deviceDate];

    To get converted date for sending to backend -serverDate method:
    NSDate *dateForSending = [synchronizedDate serverDate];

    To get interval (in seconds) use static method +intervalSinceServerDate
    NSTimeInterval interval = [APMSynchronizedDate intervalSinceServerDate];

 
## CocoaPods

This class is referenced in CocoaPods, so you can simply add `pod ios-time-synchronization` to your Podfile to add it to your pods.

## License

This code is under MIT License.
