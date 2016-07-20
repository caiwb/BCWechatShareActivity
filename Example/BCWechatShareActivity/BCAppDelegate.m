//
//  BCAppDelegate.m
//  BCWechatShareActivity
//
//  Created by caiwenbo on 07/18/2016.
//  Copyright (c) 2016 caiwenbo. All rights reserved.
//

#import "BCAppDelegate.h"
#import "BCWXSocialHandler.h"

@implementation BCAppDelegate

static const NSString *WXAppId;
static const NSString *WXAppSecret;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions NS_AVAILABLE_IOS(3_0)
{
    [[BCWXSocialHandler sharedInstance] setWXAppId:WXAppId appSecret:WXAppSecret];
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[BCWXSocialHandler sharedInstance] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[BCWXSocialHandler sharedInstance] handleOpenURL:url];
}

@end
