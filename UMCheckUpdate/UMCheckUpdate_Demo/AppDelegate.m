//
//  AppDelegate.m
//  UMCheckUpdate_Demo
//
//  Created by maojianxin on 16/4/22.
//  Copyright © 2016年 umeng.com. All rights reserved.
//

#import "AppDelegate.h"
#import "UMCheckUpdate.h"


#define APPLE_ID                    @"584748522"  // （appid数字串,demo里的是友盟客户端的）

#define DEFAULT_ITUNES_CHECKVERSION_URL    @"http://itunes.apple.com/lookup?id=%@"
#define DEFAULT_ITUNES_HOME_URL @"https://itunes.apple.com/us/app/id%@?ls=1&mt=8"

//例如只在中国地区发布, 根据实际情况去配置
#define ITUNES_CHECKVERSION_URL    @"http://itunes.apple.com/lookup?id=1021816151"
#define ITUNES_HOME_URL                  @"https://itunes.apple.com/us/app/id1021816151?ls=1&mt=8"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMCheckUpdate setLogEnabled:YES];
    [UMCheckUpdate checkUpdateWithAppID:APPLE_ID];
    
    //在不同的地区发布可能检测地址及首页地址和我们默认的不一致。
    //如果你的地址和默认的 DEFAULT_ITUNES_CHECKVERSION_URL 或 DEFAULT_ITUNES_HOME_URL 不一致。
    //请用下面这个方法初始化，一致的参数可以用nil表示。
    //[MJCheckUpdate checkUpdateWithAppID:APPLE_ID
    //                     checkUpdateUrl:ITUNES_CHECKVERSION_URL
    //                            homeUrl:ITUNES_HOME_URL];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
