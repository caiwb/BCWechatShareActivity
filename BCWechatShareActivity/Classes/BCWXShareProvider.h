//
//  BCWXShareProvider.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <Foundation/Foundation.h>
#import "WXApiObject.h"
#import "WXApi.h"

typedef NS_ENUM (NSUInteger, BCWXShareType)
{
    BCWX_SESSION  = WXSceneSession,    //分享到聊天界面
    BCWX_TIMELINE = WXSceneTimeline,   //分享到朋友圈
    BCWX_FAVORITE = WXSceneFavorite    //分享到收藏
};

@interface BCWXShareProvider : NSObject

+ (BOOL)shareWebPage:(BCWXShareType)type
           withTitle:(NSString *)title
                text:(NSString *)text
               image:(UIImage *)image
              webUrl:(NSString *)webUrl
            complete:(void(^)(BOOL suc, NSString *errMsg))complete;


+ (BOOL)shareMusic:(BCWXShareType)type
         withTitle:(NSString *)title
              text:(NSString *)text
             image:(UIImage *)image
       musicWebUrl:(NSString *)musicWebUrl
          musicUrl:(NSString *)musicUrl
          complete:(void(^)(BOOL suc, NSString *errMsg))complete;


+ (BOOL)shareVideo:(BCWXShareType)type
         withTitle:(NSString *)title
              text:(NSString *)text
             image:(UIImage *)image
       videoWebUrl:(NSString *)videoWebUrl
          complete:(void(^)(BOOL suc, NSString *errMsg))complete;


+ (BOOL)shareImage:(BCWXShareType)type
         withTitle:(NSString *)title
              text:(NSString *)text
             image:(UIImage *)image
         imageData:(NSData *)imageData
          complete:(void(^)(BOOL suc, NSString *errMsg))complete;


+ (BOOL)shareText:(BCWXShareType)type text:(NSString *)text complete:(void(^)(BOOL suc, NSString *errMsg))complete;


+ (BOOL)share:(BCWXShareType)type withTitle:(NSString *)title
         text:(NSString *)text
        image:(UIImage *)image
       webUrl:(NSString *)webUrl
  musicWebUrl:(NSString *)musicWebUrl
     musicUrl:(NSString *)musicUrl
  videoWebUrl:(NSString *)videoWebUrl
    imageData:(NSData *)imageData
     complete:(void(^)(BOOL suc, NSString *errMsg))complete;

@end
