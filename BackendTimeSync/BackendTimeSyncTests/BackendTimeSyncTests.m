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

    NSDateComponents *comp = [NSDateComponents new];
    [comp setMinute:minute];
    [comp setMonth:month];
    [comp setYear:year];
    [comp setDay:day];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.moiprofi.ru"]];
    request.HTTPMethod = @"HEAD";
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *serverDateString = response.allHeaderFields[@"Date"];
    NSDate *serverDate = [df dateFromString:serverDateString];
    
    //NSDate *serverDate = [NSDate date];

    NSString *eventDateString = @"Mon, 29 Sep 2015 15:00:00 GMT";
    NSDate *eventFromServerDate = [df dateFromString:eventDateString];

    [comp setHour:18];
    NSDate *expectedDeviceDate = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    NSString *eventToServerDateString = @"Mon, 29 Sep 2015 16:00:00 GMT";
    NSDate *eventToServerDate = [df dateFromString:eventToServerDateString];
    
    [comp setHour:19];
    NSDate *expectedServerDate = [[NSCalendar currentCalendar] dateFromComponents:comp];

    [APMSynchronizedDate setSynchronizationForServerDate:serverDate];
    
    APMSynchronizedDate *syncFromServerDate = [APMSynchronizedDate synchronizedDateFromServerDate:eventFromServerDate];
    
    NSDate *device = syncFromServerDate.deviceDate;

    XCTAssertEqualWithAccuracy([device timeIntervalSinceReferenceDate], [expectedDeviceDate timeIntervalSinceReferenceDate], 0.001);
    
    APMSynchronizedDate *syncToServerDate = [APMSynchronizedDate synchronizedDateFromDeviceDate:eventToServerDate];
    
    NSDate *server = syncToServerDate.serverDate;
    
    XCTAssertEqualWithAccuracy([server timeIntervalSinceReferenceDate], [expectedServerDate timeIntervalSinceReferenceDate], 0.001);
}

@end
