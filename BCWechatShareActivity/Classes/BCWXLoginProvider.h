//
//  BCWXLoginProvider.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>
#import "BCWXModel.h"

@interface BCWXLoginProvider : NSObject

+ (void)loginWithCompleteBlock:(void(^)(BOOL suc, NSString *accessToken, NSString *openId, NSString *errMsg))complete;

+ (void)getUserInfoWithCompleteBlock:(void (^)(BOOL suc, BCWXUserInfo *userInfo))complete;

@end
