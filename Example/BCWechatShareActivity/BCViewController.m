//
//  BCViewController.m
//  BCWechatShareActivity
//
//  Created by caiwenbo on 07/18/2016.
//  Copyright (c) 2016 caiwenbo. All rights reserved.
//

#import "BCViewController.h"
#import "BCWXShareActivity.h"

@interface BCViewController ()

@end

@implementation BCViewController

- (void)loginAndGetUserInfo
{
    [BCWXLoginProvider loginWithCompleteBlock:^(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg) {
        if (suc)
        {
            [BCWXLoginProvider getUserInfoWithCompleteBlock:^(BOOL suc, BCWXUserInfo *userInfo) {
                if (suc)
                {
                    //use userInfo
                }
            }];
        }
    }];
}

- (void)share
{
    [BCWXShareProvider shareWebPage:BCWX_SESSION
                          withTitle:@"分享到微信"
                               text:@"内容"
                              image:[UIImage imageNamed:@"thumbImage"]
                             webUrl:@"github.com"
                           complete:^(BOOL suc, NSString *errMsg) {
                               //to do after share
                           }];
}

- (void)shareOnActivityController
{
    BCWXSessionActivity *item = [[BCWXSessionActivity alloc] init];
    
    item.title = @"title";
    item.text = @"content";
    item.thumbImage = [UIImage new];
    item.webUrl = @"youdao.com";
    [item setCompleteBlock:^(BOOL suc, NSString *errMsg) {
        //to do after share
    }];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[item.title, item.webUrl, item.thumbImage] applicationActivities:@[item]];
    [self presentViewController:activityVC animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loginAndGetUserInfo];
}

@end
