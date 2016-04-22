//
//  CheckUpdateUtil.h
//  UMCheckUpdate
//
//  Created by maojianxin on 16/4/22.
//  Copyright © 2016年 umeng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UM_SAFE_STR(Object) (Object==nil?@"":Object)

void CUNSLog(NSString *format, ...);

@interface CheckUpdateUtil : NSObject

#pragma mark deviceAndOS info

//app_version
+ (NSString *)appBundleVersionString;

//appShortVersion
+ (NSString *)appShortVersionString;

+ (id)JSONValue:(NSString *)string;
@end
