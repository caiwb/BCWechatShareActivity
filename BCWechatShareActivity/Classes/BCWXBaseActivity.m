//
//  BCWXBaseActivity.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <objc/runtime.h>

#import "BCWXBaseActivity.h"
#import "WXApi.h"

@implementation BCWXBaseActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi])
    {
        for (id activityItem in activityItems)
        {
            if ([activityItem isKindOfClass:[UIImage class]])
            {
                return YES;
            }
            if ([activityItem isKindOfClass:[NSURL class]])
            {
                return YES;
            }
            if ([activityItem isKindOfClass:[NSString class]])
            {
                return YES;
            }
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems)
    {
        if ([activityItem isKindOfClass:[UIImage class]])
        {
            UIImage *image=(UIImage *)activityItem;
            self.imageData = self.imageData ?: UIImageJPEGRepresentation(image, 1.0);
        }
        if ([activityItem isKindOfClass:[NSURL class]])
        {
            NSURL *url =(NSURL *)activityItem;
            self.webUrl = self.webUrl ?: [url absoluteString];
        }
        if ([activityItem isKindOfClass:[NSString class]])
        {
            NSString *text=(NSString *)activityItem;
            self.text = self.text ?: text;
        }
    }
}

- (void)performActivity
{
    if (![BCWXShareProvider share: self.type
                        withTitle: self.title
                             text: self.text
                            image: self.thumbImage
                           webUrl: self.webUrl
                      musicWebUrl: self.musicWebUrl
                         musicUrl: self.musicUrl
                      videoWebUrl: self.videoWebUrl
                        imageData: self.imageData
                         complete: self.completeBlock] && self.completeBlock)
    {
        self.completeBlock(NO, @"share request failed");
    }
    
    [self activityDidFinish:YES];
    
    if (self.actionBlock)
    {
        self.actionBlock([self class]);
    }
}


- (NSString *)title
{
    _title = _title ?: objc_getAssociatedObject(self, "title");
    return _title;
}

- (NSString *)text
{
    _text = _text ?: objc_getAssociatedObject(self, "text");
    return _text;
}

- (NSString *)webUrl
{
    _webUrl = _webUrl ?: objc_getAssociatedObject(self, "webUrl");
    return _webUrl;
}

- (UIImage *)thumbImage
{
    _thumbImage = _thumbImage ?: objc_getAssociatedObject(self, "thumbImage");
    return _thumbImage;
}

- (NSString *)musicWebUrl
{
    _musicWebUrl = _musicWebUrl ?: objc_getAssociatedObject(self, "webUrl");
    return _musicWebUrl;
}

- (NSString *)musicUrl
{
    _musicUrl = _musicUrl ?: objc_getAssociatedObject(self, "musicUrl");
    return _musicUrl;
}

- (NSString *)videoWebUrl
{
    _videoWebUrl = _videoWebUrl ?: objc_getAssociatedObject(self, "webUrl");
    return _videoWebUrl;
}

- (NSData *)imageData
{
    _imageData = _imageData ?: objc_getAssociatedObject(self, "imageData");
    return _imageData;
}


@end
