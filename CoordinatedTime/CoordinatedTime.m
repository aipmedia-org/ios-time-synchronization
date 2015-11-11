//
//  CoordinatedTime.m
//  CoordinatedTime
//
//  Created by Andrey Toropchin on 11.11.15.
//  Copyright © 2015 aipmedia. All rights reserved.
//

#import "CoordinatedTime.h"

static NSDateFormatter* sDateFormatter = nil;

@implementation CoordinatedTime
{
    NSTimeInterval _originTimeInterval;
    BOOL _isDeviceDate;
}

+ (void)coordinateDeviceTime:(NSDate*)deviceDate withServerTime:(NSDate*)serverDate
{
    NSTimeInterval deviceTimeInterval = [deviceDate timeIntervalSince1970];
    NSTimeInterval serverTimeInterval = [serverDate timeIntervalSince1970];
    [self setDifferenceTimeInterval:(deviceTimeInterval - serverTimeInterval)];
}

+ (void)coordinateDeviceTime:(NSDate*)deviceDate withServerResponse:(NSHTTPURLResponse*)response
{
    NSString* serverDateString = response.allHeaderFields[@"Date"];
    if (serverDateString.length > 0)
        [self coordinateDeviceTime:deviceDate withServerTime:[[self dateFormatter] dateFromString:serverDateString]];
}

- (instancetype)initWithDeviceTime:(NSDate*)date
{
    self = [super init];
    if (self != nil)
    {
        _originTimeInterval = [date timeIntervalSince1970];
        _isDeviceDate = YES;
    }
    return self;
}

- (instancetype)initWithServerTime:(NSDate*)date
{
    self = [super init];
    if (self != nil)
    {
        _originTimeInterval = [date timeIntervalSince1970];
        _isDeviceDate = NO;
    }
    return self;
}

- (NSDate*)dateForDevice
{
    return [NSDate dateWithTimeIntervalSince1970:(_isDeviceDate ? _originTimeInterval : (_originTimeInterval + [[self class] differenceTimeInterval]))];
}

- (NSDate*)dateForServer
{
    return [NSDate dateWithTimeIntervalSince1970:(!_isDeviceDate ? _originTimeInterval : (_originTimeInterval - [[self class] differenceTimeInterval]))];
}

#pragma mark -
#pragma mark *** Private Interface ***
#pragma mark -

+ (NSDateFormatter*)dateFormatter
{
    if (sDateFormatter == nil)
    {
        sDateFormatter = [[NSDateFormatter alloc] init];
        sDateFormatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
    }
    return sDateFormatter;
}

+ (void)setDifferenceTimeInterval:(NSTimeInterval)timeInterval
{
    [[NSUserDefaults standardUserDefaults] setDouble:timeInterval forKey:NSStringFromClass([self class])];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSTimeInterval)differenceTimeInterval
{
    return [[NSUserDefaults standardUserDefaults] doubleForKey:NSStringFromClass([self class])];
}

@end
