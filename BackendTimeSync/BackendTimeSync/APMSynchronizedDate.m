//
//  APMSynchronizedDate.m
//  Helpers
//
//  Created by spens on 28/09/15.
//  Copyright © 2015 A&P Media. All rights reserved.
//

#import "APMSynchronizedDate.h"

static NSTimeInterval interval;

@implementation APMSynchronizedDate
{
    NSDate *_eventDate;
}

/**
 * Initialize synchronized date from server date
 */
- (instancetype)initWithServerDate:(NSDate *)serverDate
{
    if (self = [super init]) {
        _eventDate = serverDate;
    }
    return self;
}

/**
 * Initialize synchronized date from device date
 */
- (instancetype)initWithDeviceDate:(NSDate *)deviceDate
{
    if (self = [super init]) {
        _eventDate = deviceDate;
    }
    return self;
}

/**
 * Calculate synchronization interval between date on server and on device.
 * Save it statically.
 */
+ (void)setSynchronizationForServerDate:(NSDate *)serverDate andDeviceDate:(NSDate *)deviceDate
{
    interval = [serverDate timeIntervalSinceDate:deviceDate];
    if ((int)interval == 0) {
        interval = 0;
    } else {
        interval = 100.0 * floorf(interval/100.0);
    }
    NSLog(@"interval: %f", interval);
}

+ (void)setSynchronizationForServerDate:(NSDate *)serverDate
{
    NSDate *current = [NSDate date];
    interval = [serverDate timeIntervalSinceDate:current];
    if ((int)interval == 0) {
        interval = 0;
    } else {
        interval = 100.0 * floorf(interval/100.0);
    }
    NSLog(@"interval: %f", interval);
}

/**
 * Create synchronized date from server date
 */
+ (APMSynchronizedDate *)synchronizedDateFromServerDate:(NSDate *)serverDate
{
    APMSynchronizedDate *date = [[APMSynchronizedDate alloc] initWithServerDate:serverDate];
    return date;
}

/**
 * Create synchronized date from device date
 */
+ (APMSynchronizedDate *)synchronizedDateFromDeviceDate:(NSDate *)deviceDate
{
    APMSynchronizedDate *date = [[APMSynchronizedDate alloc] initWithServerDate:deviceDate];
    return date;
}

/**
 * Returns device date synchronized with server date
 */
- (NSDate *)deviceDate
{
    NSDate *date = [[NSDate alloc] initWithTimeInterval:-interval sinceDate:_eventDate];
    return date;
}

/**
 * Returns server date
 */
- (NSDate *)serverDate
{
    NSDate *date = [[NSDate alloc] initWithTimeInterval:interval sinceDate:_eventDate];
    return date;
}

@end
