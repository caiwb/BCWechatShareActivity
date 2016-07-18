//
//  BCWXShareProvider.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCWXShareProvider.h"
#import "BCWXSocialHandler.h"

@implementation BCWXShareProvider


+ (BOOL)shareWebPage:(BCWXShareType)type withTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image webUrl:(NSString *)webUrl complete:(void(^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text image:image webUrl:webUrl musicWebUrl:nil musicUrl:nil videoWebUrl:nil imageData:nil complete:complete];
}



+ (BOOL)shareMusic:(BCWXShareType)type withTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image musicWebUrl:(NSString *)musicWebUrl musicUrl:(NSString *)musicUrl complete:(void(^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text image:image webUrl:nil musicWebUrl:musicWebUrl musicUrl:musicUrl videoWebUrl:nil imageData:nil complete:complete];
}



+ (BOOL)shareVideo:(BCWXShareType)type withTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image videoWebUrl:(NSString *)videoWebUrl complete:(void(^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text image:image webUrl:nil musicWebUrl:nil musicUrl:nil videoWebUrl:videoWebUrl imageData:nil complete:complete];
}



+ (BOOL)shareImage:(BCWXShareType)type withTitle:(NSString *)title text:(NSString *)text image:(UIImage *)image imageData:(NSData *)imageData complete:(void(^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:title text:text image:image webUrl:nil musicWebUrl:nil musicUrl:nil videoWebUrl:nil imageData:imageData complete:complete];
}



+ (BOOL)shareText:(BCWXShareType)type text:(NSString *)text complete:(void(^)(BOOL suc, NSString *errMsg))complete
{
    return [self share:type withTitle:nil text:text image:nil webUrl:nil musicWebUrl:nil musicUrl:nil videoWebUrl:nil imageData:nil complete:complete];
}



+ (BOOL)share:(BCWXShareType)type withTitle:(NSString *)title
         text:(NSString *)text
        image:(UIImage *)image
       webUrl:(NSString *)webUrl
  musicWebUrl:(NSString *)musicWebUrl
     musicUrl:(NSString *)musicUrl
  videoWebUrl:(NSString *)videoWebUrl
    imageData:(NSData *)imageData
     complete:(void(^)(BOOL suc, NSString *errMsg))complete
{
    NSParameterAssert(complete);
    
    [BCWXSocialHandler sharedInstance].shareComplete = complete;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    if (!image)
    {
        req.text = text ?: title;
        req.bText = YES;
    }
    else
    {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = text;
        //        message.thumbData = [self compressImage:image downToSize:32 * 1024];
        message.thumbData = [self resizeWithImage:image];
        
        if (webUrl)
        {
            WXWebpageObject *object = [WXWebpageObject object];
            object.webpageUrl = webUrl;
            message.mediaObject = object;
        }
        else if (musicWebUrl && musicUrl)
        {
            WXMusicObject *object = [WXMusicObject object];
            object.musicUrl = musicWebUrl;
            object.musicLowBandUrl = musicWebUrl;
            object.musicDataUrl = musicUrl;
            object.musicLowBandDataUrl = musicUrl;
            message.mediaObject = object;
        }
        else if (videoWebUrl)
        {
            WXVideoObject *object = [WXVideoObject object];
            object.videoUrl = videoWebUrl;
            object.videoLowBandUrl = videoWebUrl;
            message.mediaObject = object;
        }
        else if (imageData)
        {
            WXImageObject *object = [WXImageObject object];
            object.imageData = imageData;
            message.mediaObject = object;
        }
        else
        {
            complete(NO, @"share content error");
            return NO;
        }
        
        req.bText = NO;
        req.message = message;
    }
    req.scene = type;
    
    BOOL suc = [WXApi sendReq:req];
    if (!suc)
    {
        complete(NO, @"share requset failed");
    }
    return suc;
}

+ (void)setThumbImage:(UIImage *)image inMessage:(WXMediaMessage *)message
{
    if (image)
    {
        CGFloat width = 100.0f;
        CGFloat height = image.size.height * 100.0f / image.size.width;
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [image drawInRect:CGRectMake(0, 0, width, height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [message setThumbImage:scaledImage];
    }
}

+ (NSData *)compressImage:(UIImage *)image downToSize:(NSUInteger)size
{
    CGFloat compression = 1.0f;
    CGFloat scale = [UIScreen mainScreen].scale;
    NSData *imageData = [self resizeWithImage:image scale:scale compression:compression];
    
    while ([imageData length] > size && compression > 0.1)
    {
        compression -= 0.1;
        imageData = [self resizeWithImage:image scale:scale compression:compression];
    }
    while ([imageData length] > size && scale > 0.1)
    {
        scale -= 0.1;
        imageData = [self resizeWithImage:image scale:scale compression:compression];
    }
    return imageData;
}


+ (NSData *)resizeWithImage:(UIImage *)image scale:(CGFloat)scale compression:(CGFloat)compression
{
    CGSize newSize = CGSizeMake(image.size.width * scale, image.size.height * scale);
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImageJPEGRepresentation(newImage, compression);
}


+ (NSData *)resizeWithImage:(UIImage *)image
{
    CGFloat width = 100.0f;
    CGFloat height = image.size.height * 100.0f / image.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImageJPEGRepresentation(scaledImage, 1.0f);
}

@end
