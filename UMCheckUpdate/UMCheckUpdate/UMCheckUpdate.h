//
//  UMCheckUpdate.h
//  CheckUpdate
//
//  Created by maojianxin on 16/4/21.
//  Copyright © 2016年 umeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UMCheckUpdate : NSObject

/** 按appId检测更新
 检查当前app是否有更新，有则弹出UIAlertView提示用户,当用户点击升级按钮时app会跳转到您预先设置的网址。
 无更新不做任何操作。
 检测在itunes的版本和当前版本对比.
 @param appId 苹果APPID.
 @return void.
 */
+ (void)checkUpdateWithAppID:(NSString *)appId;


/** 按appId检测更新
 检查当前app是否有更新，有则弹出UIAlertView提示用户,当用户点击升级按钮时app会跳转到您预先设置的网址。
 无更新不做任何操作。
 检测在itunes的版本和当前版本对比.
 @param appId 苹果APPID.
 @param checkUrl appstore检测更新的url.
 @param homeUrl appstore首页url.
 @return void.
 */
+ (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl;

/** 按appId检测更新
 检查当前app是否有更新，有则弹出UIAlertView提示用户,当用户点击升级按钮时app会跳转到您预先设置的网址。
 无更新不做任何操作。
 检测在itunes的版本和当前版本对比.
 @param appId 苹果APPID.
 @param checkUrl appstore检测更新的url.
 @param homeUrl appstore首页url.
 @param title 对应UIAlertView的title.
 @param cancelTitle 对应UIAlertView的cancelTitle.
 @param otherTitle 对应UIAlertView的otherTitle.
 @return void.
 */

+ (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelTitle
           otherButtonTitles:(NSString *)otherTitle;


/** 设置是否打印sdk的log信息, 默认NO(不打印log).
 @param value 设置为YES, SDK 会输出log信息可供调试参考. 除非特殊需要，否则发布产品时需改回NO.
 @return void.
 */
+ (void)setLogEnabled:(BOOL)value;

@end