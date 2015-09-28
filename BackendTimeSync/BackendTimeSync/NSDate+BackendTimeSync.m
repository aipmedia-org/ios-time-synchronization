//
//  NSDate+BackendTimeSync.m
//  Helpers
//
//  Created by spens on 28/09/15.
//  Copyright © 2015 ru.spens. All rights reserved.
//

#import "NSDate+BackendTimeSync.h"

static NSTimeInterval interval;

@implementation NSDate (BackendTimeSync)

- (NSDate *)deviceEventTime {
    interval = [self timeIntervalBetweenClientAndServer];
    
    NSDate *deviceEventTime = [[NSDate alloc] initWithTimeInterval:-interval sinceDate:self];
    NSLog(@"device event time %@", deviceEventTime);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
    df.timeZone = [NSTimeZone systemTimeZone];
    NSString *deviceEventTimeString = [df stringFromDate:deviceEventTime];
    NSLog(@"device event time string %@", deviceEventTimeString);
    
    return deviceEventTime;
}

- (NSDate *)serverEventTime
{
    NSDate *serverEventTime = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    //NSDate *serverEventTime = self;
    NSLog(@"server event time %@", serverEventTime);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
    df.timeZone = [NSTimeZone systemTimeZone];
    NSString *serverEventTimeString = [df stringFromDate:self];
    NSLog(@"server event time string %@", serverEventTimeString);

    return serverEventTime;
}

#pragma mark - Private

- (NSTimeInterval)timeIntervalBetweenClientAndServer
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://api.moiprofi.ru"]];
    request.HTTPMethod = @"HEAD";
    
    NSHTTPURLResponse *response;
    NSError *error;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (!error) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"EEE, dd MMM yyyy HH:mm:ss z";
        
        NSDate *currentDate = [NSDate date];
        NSString *serverDateString = response.allHeaderFields[@"Date"];
        NSDate *serverDate = [df dateFromString:serverDateString];
        
        NSLog(@"current date %@", currentDate);
        NSLog(@"server date %@", serverDate);
        
        NSTimeInterval ti = [serverDate timeIntervalSinceDate:currentDate];
        ti = 100.0 * floorf(ti/100.0);
        NSLog(@"interval %f", ti);
        
        return ti;
    } else {
        return 0;
    }
}

@end
