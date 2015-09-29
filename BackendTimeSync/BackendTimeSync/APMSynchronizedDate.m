//
//  APMSynchronizedDate.m
//  Helpers
//
//  Created by spens on 28/09/15.
//  Copyright © 2015 A&P Media. All rights reserved.
//

#import "APMSynchronizedDate.h"

static NSTimeInterval intervalBetweenDates;

@implementation APMSynchronizedDate
{
    NSDate *_serverDate;
}

/**
 * Initialize synchronized date from server date
 */
- (instancetype)initWithServerDate:(NSDate *)serverDate
{
    if (self = [super init]) {
        _serverDate = serverDate;
    }
    return self;
}

/**
 * Initialize synchronized date from device date
 */
- (instancetype)initWithDeviceDate:(NSDate *)deviceDate
{
    if (self = [super init]) {
        _serverDate = [[NSDate alloc] initWithTimeInterval:intervalBetweenDates sinceDate:deviceDate];
    }
    return self;
}

/**
 * Calculate synchronization interval between date on server and on device.
 * Save it statically.
 */
+ (void)updateSynchronizationIntervalForCurrentServerDate:(NSDate *)currentServerDate andCurrentDeviceDate:(NSDate *)currentDeviceDate
{
    intervalBetweenDates = [currentServerDate timeIntervalSinceDate:currentDeviceDate];
    if ((int)intervalBetweenDates == 0) {
        intervalBetweenDates = 0;
    } else {
        intervalBetweenDates = 100.0 * floorf(intervalBetweenDates/100.0);
    }
}

+ (void)updateSynchronizationIntervalForCurrentServerDate:(NSDate *)currentServerDate
{
    NSDate *current = [NSDate date];
    [APMSynchronizedDate updateSynchronizationIntervalForCurrentServerDate:currentServerDate andCurrentDeviceDate:current];
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
    APMSynchronizedDate *date = [[APMSynchronizedDate alloc] initWithDeviceDate:deviceDate];
    return date;
}

/**
 * Returns device date synchronized with server date
 */
- (NSDate *)deviceDate
{
    NSDate *date = [[NSDate alloc] initWithTimeInterval:-intervalBetweenDates sinceDate:_serverDate];
    return date;
}

/**
 * Returns server date
 */
- (NSDate *)serverDate
{
    return _serverDate;
}

+ (NSTimeInterval)intervalBetweenDates
{
    return intervalBetweenDates;
}

@end
