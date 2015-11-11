//
//  CoordinatedTime.h
//  CoordinatedTime
//
//  Created by Andrey Toropchin on 11.11.15.
//  Copyright © 2015 aipmedia. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `CoordinatedTime` is a class for coordinating device local time with servers's time.
 All dates that are visible to user should be "device coordinated" dates (`dateForDevice`).
 All dates that are sent to server should be "server coordinated" dates (`dateForServer`).
 */

@interface CoordinatedTime : NSObject

/** Calculates and saves time difference between device and server */
+ (void)coordinateDeviceTime:(NSDate*)deviceDate withServerTime:(NSDate*)serverDate;

/** Convinience method to calculate and save time difference between device and server's response */
+ (void)coordinateDeviceTime:(NSDate*)deviceDate withServerResponse:(NSHTTPURLResponse*)response;

/** Initializer with device origin date */
- (instancetype)initWithDeviceTime:(NSDate*)date;

/** Initializer with server origin date */
- (instancetype)initWithServerTime:(NSDate*)date;

/** Date to be used on device (UI) */
- (NSDate*)dateForDevice;

/** Date to be used on server (requests) */
- (NSDate*)dateForServer;

@end
