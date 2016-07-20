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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions NS_AVAILABLE_IOS(3_0)
{
    [[BCWXSocialHandler sharedInstance] setWXAppId:@"appId" appSecret:@"appKey"];
    
    return YES;
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
