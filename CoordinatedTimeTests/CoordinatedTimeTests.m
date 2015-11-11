//
//  CoordinatedTimeTests.m
//  CoordinatedTimeTests
//
//  Created by Andrey Toropchin on 11.11.15.
//  Copyright © 2015 aipmedia. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoordinatedTime.h"

@interface CoordinatedTimeTests : XCTestCase
@end

@implementation CoordinatedTimeTests

- (void)makeServerTimeDifference:(NSTimeInterval)difference
{
    NSDate* now = [NSDate date];
    NSTimeInterval serverTime = [now timeIntervalSince1970] + difference;

    [CoordinatedTime coordinateDeviceTime:now withServerTime:[NSDate dateWithTimeIntervalSince1970:serverTime]];
}

- (void)testInitializedWithDeviceDateShouldReturnSameDeviceCoordinatedDate
{
    NSDate* now = [NSDate date];

    CoordinatedTime* time = [[CoordinatedTime alloc] initWithDeviceTime:now];
    XCTAssertEqualWithAccuracy([now timeIntervalSince1970], [[time dateForDevice] timeIntervalSince1970], 0.001);
}

- (void)testInitializedWithDeviceDateShouldReturnCorrentServerCoordinatedDate
{
    // Positive difference
    NSTimeInterval difference = 42.;
    [self makeServerTimeDifference:difference];

    NSDate* now = [NSDate date];
    CoordinatedTime* time = [[CoordinatedTime alloc] initWithDeviceTime:now];
    XCTAssertEqualWithAccuracy([now timeIntervalSince1970], [[time dateForServer] timeIntervalSince1970] - difference, 0.001);

    // Negative difference
    difference = -42.;
    [self makeServerTimeDifference:difference];

    now = [NSDate date];
    time = [[CoordinatedTime alloc] initWithDeviceTime:now];
    XCTAssertEqualWithAccuracy([now timeIntervalSince1970], [[time dateForServer] timeIntervalSince1970] - difference, 0.001);
}

- (void)testInitializedWithServerDateShouldReturnSameServerCoordinatedDate
{
    NSDate* now = [NSDate date];

    CoordinatedTime* time = [[CoordinatedTime alloc] initWithServerTime:now];
    XCTAssertEqualWithAccuracy([now timeIntervalSince1970], [[time dateForServer] timeIntervalSince1970], 0.001);
}

- (void)testInitializedWithServerDateShouldReturnCorrentDeviceCoordinatedDate
{
    // Positive difference
    NSTimeInterval difference = 42.;
    [self makeServerTimeDifference:difference];

    NSDate* now = [NSDate date];
    CoordinatedTime* time = [[CoordinatedTime alloc] initWithServerTime:now];
    XCTAssertEqualWithAccuracy([now timeIntervalSince1970] - difference, [[time dateForDevice] timeIntervalSince1970], 0.001);

    // Negative difference
    difference = -42.;
    [self makeServerTimeDifference:difference];

    now = [NSDate date];
    time = [[CoordinatedTime alloc] initWithServerTime:now];
    XCTAssertEqualWithAccuracy([now timeIntervalSince1970] - difference, [[time dateForDevice] timeIntervalSince1970], 0.001);
}

@end
