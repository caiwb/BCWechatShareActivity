//
//  BCWXSocialHandler.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <AFNetworking/AFNetworking.h>

#define WX_ACCESS_TOKEN  @"WX_ACCESS_TOKEN"
#define WX_REFRESH_TOKEN @"WX_REFRESH_TOKEN"
#define WX_OPEN_ID       @"WX_OPEN_ID"

#define weaklyBCWXHandler() __weak BCWXSocialHandler *weakHandler = [BCWXSocialHandler sharedInstance]

@interface BCWXSocialHandler : NSObject <WXApiDelegate>

@property (nonatomic, strong) NSString *appId;

@property (nonatomic, strong) NSString *appSecret;

@property (nonatomic, strong) NSString *accessToken;

@property (nonatomic, strong) NSString *refreshToken;

@property (nonatomic, strong) NSString *openId;

@property (nonatomic, assign) BOOL reAuthorize;

@property (nonatomic, strong) AFHTTPRequestOperationManager *networkManager;

@property (nonatomic, strong) void (^loginComplete)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg);

@property (nonatomic, strong) void (^shareComplete)(BOOL suc, NSString *errMsg);

@property (nonatomic, assign) BOOL isWXInstall;

+ (instancetype)sharedInstance;

- (BOOL)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
