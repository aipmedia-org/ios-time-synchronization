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

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTimeSync
{
    NSInteger minute = 0;
    NSInteger month = 9;
    NSInteger day = 29;
    NSInteger year = 2015;
    NSInteger serverHour = 10;
    NSInteger deviceHour = 11;
    NSTimeInterval expectedInterval = (serverHour - deviceHour) * 60 * 60;

    NSDateComponents *comp = [NSDateComponents new];
    [comp setMinute:minute];
    [comp setMonth:month];
    [comp setYear:year];
    [comp setDay:day];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";

    
    [comp setHour:serverHour];
    NSDate *currentServerDate = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    [comp setHour:deviceHour];
    NSDate *currentDeviceDate = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    [APMSynchronizedDate updateSynchronizationIntervalForCurrentServerDate:currentServerDate andCurrentDeviceDate:currentDeviceDate];
    
    NSInteger interval = [APMSynchronizedDate interval];
    XCTAssertEqual(interval, expectedInterval);
    
    
    
    NSString *eventDateString = @"Mon, 29 Sep 2015 15:00:00 GMT";
    NSDate *eventFromServerDate = [df dateFromString:eventDateString];
    
    NSString *expectedDateString = @"Mon, 29 Sep 2015 16:00:00 GMT";
    NSDate *expectedDeviceDate = [df dateFromString:expectedDateString];
    
    APMSynchronizedDate *syncFromServerDate = [APMSynchronizedDate synchronizedDateFromServerDate:eventFromServerDate];
    
    NSDate *calculatedDeviceDate = syncFromServerDate.deviceDate;
    XCTAssertEqualWithAccuracy([calculatedDeviceDate timeIntervalSinceReferenceDate], [expectedDeviceDate timeIntervalSinceReferenceDate], 0.001);
    
    NSDate *calculatedServerDate = syncFromServerDate.serverDate;
    XCTAssertEqualWithAccuracy([calculatedServerDate timeIntervalSinceReferenceDate], [eventFromServerDate timeIntervalSinceReferenceDate], 0.001);

    
    
    [comp setHour:20];
    NSDate *eventToServerDate = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    NSString *expectedServerDateString = @"Mon, 29 Sep 2015 16:00:00 GMT";
    NSDate *expectedServerDate = [df dateFromString:expectedServerDateString];
    
    APMSynchronizedDate *syncToServerDate = [APMSynchronizedDate synchronizedDateFromDeviceDate:eventToServerDate];
    
    calculatedServerDate = syncToServerDate.serverDate;
    XCTAssertEqualWithAccuracy([calculatedServerDate timeIntervalSinceReferenceDate], [expectedServerDate timeIntervalSinceReferenceDate], 0.001);
    
    calculatedDeviceDate = syncToServerDate.deviceDate;
    XCTAssertEqualWithAccuracy([calculatedDeviceDate timeIntervalSinceReferenceDate], [eventToServerDate timeIntervalSinceReferenceDate], 0.001);
}

@end
