//
//  BackendTimeSyncTests.m
//  BackendTimeSyncTests
//
//  Created by spens on 28/09/15.
//  Copyright © 2015 A&P Media. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BackendTimeSync.h"

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

- (void)testDeviceEventTime
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
    NSString *eventDateString = @"Mon, 28 Sep 2015 18:00:00 GMT";
    NSDate *eventDateFromServer = [df dateFromString:eventDateString];
    NSDate *deviceTime = [eventDateFromServer deviceEventTime];
    
    NSDateComponents *comp = [NSDateComponents new];
    [comp setHour:21];
    [comp setMinute:0];
    [comp setMonth:9];
    [comp setYear:2015];
    [comp setDay:28];
    NSDate *expectedDate = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    XCTAssertEqualWithAccuracy([deviceTime timeIntervalSinceReferenceDate], [expectedDate timeIntervalSinceReferenceDate], 0.001);
}

- (void)testServerEventTime
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
    NSString *eventDateString = @"Mon, 28 Sep 2015 19:00:00 GMT";
    NSDate *eventDate = [df dateFromString:eventDateString];
    NSDate *serverTime = [eventDate serverEventTime];
    
    NSDateComponents *comp = [NSDateComponents new];
    [comp setHour:22];
    [comp setMinute:0];
    [comp setMonth:9];
    [comp setYear:2015];
    [comp setDay:28];
    NSDate *expectedDate = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    XCTAssertEqualWithAccuracy([serverTime timeIntervalSinceReferenceDate], [expectedDate timeIntervalSinceReferenceDate], 0.001);
}
@end
