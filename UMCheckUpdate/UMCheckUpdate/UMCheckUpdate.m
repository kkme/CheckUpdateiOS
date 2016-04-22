//
//  UMCheckUpdate.m
//  CheckUpdate
//
//  Created by maojianxin on 16/4/21.
//  Copyright © 2016年 umeng. All rights reserved.
//

// update
#define ITUNES_CHECKVERSION_URL    @"http://itunes.apple.com/lookup?id=%@"
#define ITUNES_HOME_URL @"https://itunes.apple.com/us/app/id%@?ls=1&mt=8"

//自动更新alertView标题
#define newUpdateTitle NSLocalizedStringWithDefaultValue(@"umUpdateTitle",nil,[NSBundle mainBundle], @"有可用的新版本",@"Umeng Update");
#define newUpdateCancelButtonTitle NSLocalizedStringWithDefaultValue(@"umUpdateCancel",nil,[NSBundle mainBundle], @"忽略此版本",@"Umeng Update");
#define newUpdateOtherButtonTitles NSLocalizedStringWithDefaultValue(@"umUpdateOK",nil,[NSBundle mainBundle], @"访问 Store",@"Umeng Update");

//赋值的时候时候，为nil就用默认值
#define UM_SET_VALUE(Object,Str) (Object==nil || [Object length] == 0 ?Str:Object)


#import <UIKit/UIKit.h>
#import "UMCheckUpdate.h"
#import "CheckUpdateUtil.h"


@interface UMCheckUpdate ()
@property(nonatomic, copy) NSString *appId;
@property(nonatomic, copy) NSString *appHomeUrl;
@property(nonatomic, copy) NSString *appCheckUpdateUrl;
@property(nonatomic, copy) NSString *updateCancelButtonTitle;
@property(nonatomic, copy) NSString *updateOtherButtonTitles;
@property(nonatomic, copy) NSString *updateTitle;
@property(nonatomic, retain) NSMutableDictionary *updateInfo;
@property(nonatomic, copy) NSString *appVersion;
@property(strong, nonatomic) NSOperationQueue *queue;
@property(nonatomic) BOOL logEnabled;

+ (UMCheckUpdate *)sharedInstance;

- (void)checkUpdateAppID:(NSString *)appId
          checkUpdateUrl:(NSString *)checkUrl
                 homeUrl:(NSString *)homeUrl
                   title:(NSString *)title
       cancelButtonTitle:(NSString *)cancelTitle
       otherButtonTitles:(NSString *)otherTitle;

- (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelTitle
           otherButtonTitles:(NSString *)otherTitle;

@end

@implementation UMCheckUpdate

+ (UMCheckUpdate *)sharedInstance {
    static UMCheckUpdate *_instance = nil;
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
            _instance.updateTitle = newUpdateTitle;
            _instance.updateCancelButtonTitle = newUpdateCancelButtonTitle;
            _instance.updateOtherButtonTitles = newUpdateOtherButtonTitles;
            _instance.appVersion = [CheckUpdateUtil appShortVersionString];
            _instance.updateInfo = [NSMutableDictionary dictionary];
        }
    }
    
    return _instance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
        [self.queue setMaxConcurrentOperationCount:1];
    }
    
    return self;
}

+ (void)setLogEnabled:(BOOL)value {
    [UMCheckUpdate sharedInstance].logEnabled = value;
}

+ (void)checkUpdateWithAppID:(NSString *)appId {
    [[UMCheckUpdate sharedInstance] checkUpdateWithAppID:appId checkUpdateUrl:nil homeUrl:nil  title:nil cancelButtonTitle:nil otherButtonTitles:nil];
}

+ (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl {
    
    [[UMCheckUpdate sharedInstance] checkUpdateWithAppID:appId checkUpdateUrl:checkUrl homeUrl:homeUrl  title:nil cancelButtonTitle:nil otherButtonTitles:nil];
}

+ (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelTitle
           otherButtonTitles:(NSString *)otherTitle {
    
    [[UMCheckUpdate sharedInstance] checkUpdateWithAppID:appId checkUpdateUrl:checkUrl homeUrl:homeUrl  title:title cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle];
}

- (void)checkUpdateWithAppID:(NSString *)appId
              checkUpdateUrl:(NSString *)checkUrl
                     homeUrl:(NSString *)homeUrl
                       title:(NSString *)title
           cancelButtonTitle:(NSString *)cancelTitle
           otherButtonTitles:(NSString *)otherTitle {
    
    if (!appId || [appId length] == 0) {
        CUNSLog(@"UMCheckUpdateLOG: please provide appId!");
        return;
    }
    
    NSString *defaultCheckUrl = [NSString stringWithFormat:ITUNES_CHECKVERSION_URL, appId];
    NSString *defaultHomeUrl = [NSString stringWithFormat:ITUNES_HOME_URL, appId];
    
    checkUrl = UM_SET_VALUE(checkUrl, defaultCheckUrl);
    homeUrl = UM_SET_VALUE(homeUrl, defaultHomeUrl);
    //demo里混用的时候title会混掉，不影响实际使用。或改成默认值
    title = UM_SET_VALUE(title,  self.updateTitle);
    cancelTitle = UM_SET_VALUE(cancelTitle, self.updateCancelButtonTitle);
    otherTitle = UM_SET_VALUE(otherTitle, self.updateOtherButtonTitles);
    
    [[UMCheckUpdate sharedInstance] checkUpdateAppID:appId checkUpdateUrl:checkUrl homeUrl:homeUrl  title:title cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle];
}

- (void)checkUpdateAppID:(NSString *)appId
          checkUpdateUrl:(NSString *)checkUrl
                 homeUrl:(NSString *)homeUrl
                   title:(NSString *)title
       cancelButtonTitle:(NSString *)cancelTitle
       otherButtonTitles:(NSString *)otherTitle {
    
    self.appId = appId;
    self.appCheckUpdateUrl = checkUrl;
    self.appHomeUrl = homeUrl;
    self.updateTitle = title;
    self.updateCancelButtonTitle = cancelTitle;
    self.updateOtherButtonTitles = otherTitle;
    
    NSInvocationOperation *checkUpdateOperation =
    [[NSInvocationOperation alloc] initWithTarget:self
                                         selector:@selector(checkAppUpdateResult)
                                           object:nil];
    
    [self.queue addOperation:checkUpdateOperation];
}

- (void)checkAppUpdateResult {
    [self checkAppUpdate:self.appCheckUpdateUrl];
}

- (BOOL)checkAppUpdate:(NSString *)serverUrl {
    
    NSError *error;
    
    NSURL *url = [NSURL URLWithString:serverUrl];
    
    NSString *jsonResponseString =  [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (jsonResponseString != nil) {
        //解析json数据为数据字典
        NSDictionary *itunesResponse = [CheckUpdateUtil JSONValue:jsonResponseString];
        [self executeUpdate:itunesResponse];
        return YES;
    } else {
        if (error != nil) {
            CUNSLog(@"(Error    checkAppUpdate) %@", error);
        }
        return NO;
    }
}

- (void)executeUpdate:(NSDictionary *)itunesResponse {
    NSString *newVersion;
    NSString *releaseNotes;
    
    NSArray *configData = [itunesResponse valueForKey:@"results"];
    for(id config in configData)
    {
        //从数据字典中检出版本号数据及更新记录
        newVersion = [config valueForKey:@"version"];
        releaseNotes = [config objectForKey:@"releaseNotes"];
    }
    
    //updateInfo 供扩展使用
    [self.updateInfo setObject:newVersion forKey:@"newVersion"];
    [self.updateInfo setObject:releaseNotes forKey:@"releaseNotes"];
    
    CUNSLog(@"通过appStore获取的版本号是:%@, 当前版本号:%@",newVersion, self.appVersion);
    
    //用appstroe获取的版本号与当前的版本号对比。
    //注意：需要用ShortVersion而不是BundleVersion
    if ([newVersion compare:self.appVersion options:NSNumericSearch] == NSOrderedDescending) {
        [self performSelectorOnMainThread:@selector(appUpdateWithAlert:) withObject:self.updateInfo waitUntilDone:YES];
    }
}

- (void)appUpdateWithAlert:(NSDictionary *)objectData {
    NSString *message = objectData[@"releaseNotes"];
    NSString *newVersion = objectData[@"newVersion"];
    
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:[self.updateTitle stringByAppendingString:newVersion]
                               message:message
                              delegate:self
                     cancelButtonTitle:self.updateCancelButtonTitle otherButtonTitles:self.updateOtherButtonTitles, nil];
    
    //  #TODO 自适应message对齐方式
    [alert show];
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        // 此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appHomeUrl]];
    }
}

@end