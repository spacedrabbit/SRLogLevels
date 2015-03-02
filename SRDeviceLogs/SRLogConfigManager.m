//
//  SRLogConfigManager.m
//  SRDeviceLogs
//
//  Created by Tur, Louis on 2/26/15.
//  Copyright (c) 2015 Tur, Louis. All rights reserved.
//

#import "SRLogConfigManager.h"

static int ddLogLevel = LOG_LEVEL_WARN;

@implementation SRLogConfigManager

+(NSInteger)getSRLogLevel{
    return ddLogLevel;
}

+(void)changeToNoLogs{
    ddLogLevel = LOG_LEVEL_OFF;
    NSLog(@"Log levels are now off!");
}
+(void)changeToVerboseLogs{
    ddLogLevel = LOG_LEVEL_VERBOSE;
}
+(void)changeToErrorLogs{
    ddLogLevel = LOG_LEVEL_ERROR;
}
+(void)changeToDebugLogs{
    ddLogLevel = LOG_LEVEL_DEBUG;
}
+(void)changetoWarningLogs{
    ddLogLevel = LOG_LEVEL_WARN;
}
@end
