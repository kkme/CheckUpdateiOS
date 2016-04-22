//
//  CheckUpdateUitl.m
//  UMCheckUpdate
//
//  Created by maojianxin on 16/4/22.
//  Copyright © 2016年 umeng.com. All rights reserved.
//

#import "CheckUpdateUtil.h"
#import "UMCheckUpdate.h"

void CUNSLog(NSString *format, ...) {
    va_list ap;
    va_start(ap, format);
    
    UMCheckUpdate *update = [UMCheckUpdate performSelector:@selector(sharedInstance)];
    if ([update performSelector:@selector(logEnabled)]) {
        NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
        NSLog(@"UMCheckUpdateLOG: %@", message);
    }
}

@implementation CheckUpdateUtil

//display_name
+ (NSString *)appBundleVersionString {
    return UM_SAFE_STR([[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]);
}

+ (NSString *)appShortVersionString {
    return UM_SAFE_STR([[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]);
}

+ (id)JSONValue:(NSString *)string {
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
}

@end