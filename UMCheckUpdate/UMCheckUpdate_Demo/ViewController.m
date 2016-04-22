//
//  ViewController.m
//  UMCheckUpdate_Demo
//
//  Created by maojianxin on 16/4/22.
//  Copyright © 2016年 umeng.com. All rights reserved.
//

#import "ViewController.h"
#import "UMCheckUpdate.h"

#define APPLE_ID                    @"584748522"  // （appid数字串,demo里的是友盟客户端的）

#define ITUNES_HOME_URL  @"https://itunes.apple.com/us/app/you-meng-tong-ji-fen-xi-ke/id584748522?mt=8"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)checkUpdate:(id)sender {
    [UMCheckUpdate checkUpdateWithAppID:APPLE_ID checkUpdateUrl:nil homeUrl:ITUNES_HOME_URL];
}

- (IBAction)checkUpdateWithTitle:(id)sender {
    [UMCheckUpdate checkUpdateWithAppID:APPLE_ID checkUpdateUrl:nil homeUrl:nil title:@"升级了" cancelButtonTitle:@"取消" otherButtonTitles:@"升级去喽"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
