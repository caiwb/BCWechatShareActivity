//
//  BCWXLoginProvider.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCWXLoginProvider.h"
#import "WXApi.h"
#import "BCWXModel.h"
#import "BCWXSocialHandler.h"
#import <AFNetworking+SingleBlock/AFHTTPRequestOperationManager+SingleBlock.h>

@implementation BCWXLoginProvider

+ (void)loginWithCompleteBlock:(void(^)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg))complete
{
    NSParameterAssert(complete);
    
    [BCWXSocialHandler sharedInstance].loginComplete = complete;
    
    if (![BCWXSocialHandler sharedInstance].appId || ![BCWXSocialHandler sharedInstance].appSecret)
    {
        [BCWXSocialHandler sharedInstance].loginComplete(NO, nil, nil, @"ConfigurationError");
        return;
    }
    
    NSString *accessToken = [BCWXSocialHandler sharedInstance].accessToken ?: [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *refreshToken = [BCWXSocialHandler sharedInstance].refreshToken ?: [[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
    NSString *openId = [BCWXSocialHandler sharedInstance].openId ?: [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    
    if (accessToken && openId && refreshToken && ![BCWXSocialHandler sharedInstance].reAuthorize)
    {
        [self refreshAccessToken:refreshToken];
    }
    else
    {
        [self sendAuthRequest];
    }
}

+ (void)getUserInfoWithCompleteBlock:(void (^)(BOOL, BCWXUserInfo *))complete
{
    NSParameterAssert(complete);
    
    [BCWXSocialHandler sharedInstance].accessToken = [BCWXSocialHandler sharedInstance].accessToken ?: [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    [BCWXSocialHandler sharedInstance].openId = [BCWXSocialHandler sharedInstance].openId ?: [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    
    if (![BCWXSocialHandler sharedInstance].accessToken || ![BCWXSocialHandler sharedInstance].openId)
    {
        complete(NO, nil);
        return;
    }
    
    [[BCWXSocialHandler sharedInstance].networkManager GET:@"userinfo" parameters:@{@"access_token": [BCWXSocialHandler sharedInstance].accessToken, @"openid": [BCWXSocialHandler sharedInstance].openId} complete:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (responseObject)
        {
            BCWXUserInfo *userInfo = [[BCWXUserInfo alloc] initWithDictionary:responseObject];
            if (userInfo.errcode)
            {
                complete(NO, nil);
            }
            else
            {
                complete(YES, userInfo);
            }
        }
        else
        {
            complete(NO, nil);
        }
    }];
}

+ (void)sendAuthRequest
{
    /**
     *   snsapi_base:
     *          /sns/oauth2/access_token
     *          /sns/oauth2/refresh_token
     *          /sns/auth
     *   snsapi_userinfo:
     *          /sns/userinfo
     */
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"netease_youdao";
    [WXApi sendReq:req];
}

+ (void)refreshAccessToken:(NSString *)refreshToken
{
    weaklyBCWXHandler();
    [[BCWXSocialHandler sharedInstance].networkManager GET:@"oauth2/refresh_token" parameters:@{@"appid": [BCWXSocialHandler sharedInstance].appId, @"refresh_token": refreshToken, @"grant_type": @"refresh_token"} complete:^(AFHTTPRequestOperation *operation, id responseObject, NSError *error) {
        if (responseObject)
        {
            BCWXAccessTokenModel *model = [[BCWXAccessTokenModel alloc] initWithDictionary:responseObject];
            if (model.errcode)
            {
                [self sendAuthRequest];
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

@end
