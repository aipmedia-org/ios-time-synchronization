//
//  APMSynchronizedDate.h
//  Helpers
//
//  Created by spens on 28/09/15.
//  Copyright © 2015 A&P Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APMSynchronizedDate : NSDate

/**
 * Calculate synchronization interval between date on server and on device.
 * Save it statically.
 */
+ (void)updateSynchronizationIntervalForCurrentServerDate:(NSDate *)currentServerDate andCurrentDeviceDate:(NSDate *)currentDeviceDate;
+ (void)updateSynchronizationIntervalForCurrentServerDate:(NSDate *)currentServerDate;

/**
 * Create synchronized date from server date
 */
+ (APMSynchronizedDate *)synchronizedDateFromServerDate:(NSDate *)serverDate;
/**
 * Create synchronized date from device date
 */
+ (APMSynchronizedDate *)synchronizedDateFromDeviceDate:(NSDate *)deviceDate;


/**
 * Initialize synchronized date from server date
 */
- (instancetype)initWithServerDate:(NSDate *)serverDate;
/**
 * Initialize synchronized date from device date
 */
- (instancetype)initWithDeviceDate:(NSDate *)deviceDate;

/**
 * Returns device date synchronized with server date
 */
- (NSDate *)deviceDate;
/**
 * Returns server date
 */
- (NSDate *)serverDate;
/**
 * Returns calculated interval
 */
+ (NSTimeInterval)intervalSinceServerDate;

@end
