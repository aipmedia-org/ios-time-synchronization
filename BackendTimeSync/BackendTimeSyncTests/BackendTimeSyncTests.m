//
//  BackendTimeSyncTests.m
//  BackendTimeSyncTests
//
//  Created by spens on 28/09/15.
//  Copyright © 2015 A&P Media. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "APMSynchronizedDate.h"

@interface BackendTimeSyncTests : XCTestCase

@end

@implementation BackendTimeSyncTests
{
    NSDateComponents *components;
    NSDateFormatter *dateFormatter;
}

- (void)setUp {
    [super setUp];
    
    NSInteger minute = 0;
    NSInteger month = 9;
    NSInteger day = 29;
    NSInteger year = 2015;
    
    components = [NSDateComponents new];
    [components setMinute:minute];
    [components setMonth:month];
    [components setYear:year];
    [components setDay:day];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)updateSynchronization
{
    NSInteger serverHour = 10;
    NSInteger deviceHour = 11;
    
    [components setHour:serverHour];
    NSDate *currentServerDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    [components setHour:deviceHour];
    NSDate *currentDeviceDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    [APMSynchronizedDate updateSynchronizationIntervalForCurrentServerDate:currentServerDate andCurrentDeviceDate:currentDeviceDate];
}

- (void)testUpdateInterval
{
    NSInteger serverHour = 10;
    NSInteger deviceHour = 11;
    NSTimeInterval expectedInterval = (serverHour - deviceHour) * 60 * 60;
    
    [self updateSynchronization];
    
    NSInteger interval = [APMSynchronizedDate intervalSinceServerDate];
    XCTAssertEqual(interval, expectedInterval);
}

- (void)testSyncFromServer
{
    [self updateSynchronization];
    
    NSString *eventDateString = @"Mon, 29 Sep 2015 15:00:00 GMT";
    NSDate *eventFromServerDate = [dateFormatter dateFromString:eventDateString];
    
    NSString *expectedDateString = @"Mon, 29 Sep 2015 16:00:00 GMT";
    NSDate *expectedDeviceDate = [dateFormatter dateFromString:expectedDateString];
    
    APMSynchronizedDate *synchronizedDate = [APMSynchronizedDate synchronizedDateFromServerDate:eventFromServerDate];
    
    NSDate *calculatedDeviceDate = synchronizedDate.deviceDate;
    XCTAssertEqualWithAccuracy([calculatedDeviceDate timeIntervalSinceReferenceDate], [expectedDeviceDate timeIntervalSinceReferenceDate], 0.001);
    
    NSDate *calculatedServerDate = synchronizedDate.serverDate;
    XCTAssertEqualWithAccuracy([calculatedServerDate timeIntervalSinceReferenceDate], [eventFromServerDate timeIntervalSinceReferenceDate], 0.001);
}

- (void)testSyncToServer
{
    [self updateSynchronization];
    
    NSString *eventToServerDateString = @"Mon, 29 Sep 2015 20:00:00 GMT";
    NSDate *eventToServerDate = [dateFormatter dateFromString:eventToServerDateString];
    
    NSString *expectedServerDateString = @"Mon, 29 Sep 2015 19:00:00 GMT";
    NSDate *expectedServerDate = [dateFormatter dateFromString:expectedServerDateString];
    
    APMSynchronizedDate *synchronizedDate = [APMSynchronizedDate synchronizedDateFromDeviceDate:eventToServerDate];
    
    NSDate *calculatedServerDate = synchronizedDate.serverDate;
    XCTAssertEqualWithAccuracy([calculatedServerDate timeIntervalSinceReferenceDate], [expectedServerDate timeIntervalSinceReferenceDate], 0.001);
    
    NSDate *calculatedDeviceDate = synchronizedDate.deviceDate;
    XCTAssertEqualWithAccuracy([calculatedDeviceDate timeIntervalSinceReferenceDate], [eventToServerDate timeIntervalSinceReferenceDate], 0.001);
}

@end
