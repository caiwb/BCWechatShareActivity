//
//  BCWXSocialHandler.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCWXSocialHandler.h"
#import <AFNetworking+SingleBlock/AFHTTPRequestOperationManager+SingleBlock.h>
#import "BCWXModel.h"

@implementation BCWXSocialHandler

+ (instancetype)sharedInstance
{
    static BCWXSocialHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[BCWXSocialHandler alloc] init];
    });
    return handler;
}

- (AFHTTPRequestOperationManager *)networkManager
{
    if (! _networkManager)
    {
        _networkManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.weixin.qq.com/sns"]];
        [_networkManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/plain", @"text/html", nil]];
    }
    return _networkManager;
}

- (BOOL)setWXAppId:(NSString *)appId appSecret:(NSString *)appSecret
{
    if([WXApi registerApp:appId])
    {
        self.appId = appId;
        self.appSecret = appSecret;
        
        return YES;
    }
    return NO;
}

- (BOOL)isWXInstall
{
    return [WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[SendAuthResp class]])
    {
        SendAuthResp *aResp = (SendAuthResp *)resp;
        if (aResp.errCode == WXSuccess)
        {
            NSString *code = aResp.code ?: @"";
            
            weaklyBCWXHandler();
            [self.networkManager GET:@"oauth2/access_token" parameters:@{@"appid": self.appId, @"secret": self.appSecret, @"code": code, @"grant_type": @"authorization_code"} complete:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
                if (responseObject)
                {
                    BCWXAccessTokenModel *model = [[BCWXAccessTokenModel alloc] initWithDictionary:responseObject];
                    if (model.errcode)
                    {
                        weakHandler.loginComplete(NO, nil, nil, model.errmsg);
                    }
                    else
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:model.access_token forKey:WX_ACCESS_TOKEN];
                        [[NSUserDefaults standardUserDefaults] setObject:model.refresh_token forKey:WX_REFRESH_TOKEN];
                        [[NSUserDefaults standardUserDefaults] setObject:model.openid forKey:WX_OPEN_ID];
                        
                        weakHandler.accessToken = model.access_token;
                        weakHandler.refreshToken = model.refresh_token;
                        weakHandler.openId = model.openid;
                        
                        weakHandler.loginComplete(YES, model.access_token, model.openid, nil);
                    }
                }
                else
                {
                    weakHandler.loginComplete(NO, nil, nil, @"NetworkError");
                }
            }];
        }
        else
        {
            /**
             * WXSuccess           = 0,
             * WXErrCodeCommon     = -1,
             * WXErrCodeUserCancel = -2,
             * WXErrCodeSentFail   = -3,
             * WXErrCodeAuthDeny   = -4,
             * WXErrCodeUnsupport  = -5,
             */
            NSArray *errList = @[@"WXErrCodeCommon",
                                 @"WXErrCodeUserCancel",
                                 @"WXErrCodeSentFail",
                                 @"WXErrCodeAuthDeny",
                                 @"WXErrCodeUnsupport"];
            self.loginComplete(NO, nil, nil, errList[abs(aResp.errCode + 1)]);
        }
    }
    
    else if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //share response
        SendMessageToWXResp *sResp = (SendMessageToWXResp *)resp;
        if (sResp.errCode == WXSuccess)
        {
            self.shareComplete(YES, nil);
        }
        else
        {
            NSArray *errList = @[@"WXErrCodeCommon",
                                 @"WXErrCodeUserCancel",
                                 @"WXErrCodeSentFail",
                                 @"WXErrCodeAuthDeny",
                                 @"WXErrCodeUnsupport"];
            self.shareComplete(NO, errList[abs(sResp.errCode + 1)]);
        }
    }
}

@end

