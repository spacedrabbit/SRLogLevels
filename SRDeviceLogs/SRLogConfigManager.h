//
//  SRLogConfigManager.h
//  SRDeviceLogs
//
//  Created by Tur, Louis on 2/26/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDLog.h"

@interface SRLogConfigManager : NSObject

+(NSInteger)getSRLogLevel;

+(void)changeToNoLogs;
+(void)changetoWarningLogs;
+(void)changeToDebugLogs;
+(void)changeToErrorLogs;
+(void)changeToVerboseLogs;

@end
