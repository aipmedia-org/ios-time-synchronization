//
//  NSDate+BackendTimeSync.h
//  Helpers
//
//  Created by spens on 28/09/15.
//  Copyright © 2015 ru.spens. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BackendTimeSync)

- (NSDate *)deviceEventTime;
- (NSDate *)serverEventTime;

@end
