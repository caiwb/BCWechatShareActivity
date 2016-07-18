//
//  BCWXSessionActivity.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCWXSessionActivity.h"

@implementation BCWXSessionActivity

- (id)init
{
    if (self = [super init])
    {
        self.type = BCWX_SESSION;
    }
    return self;
}

- (UIImage *)activityImage
{
    UIImage *image = [UIImage imageNamed:@"wechat_session_icon"];
    
    CGSize size = image.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    UIBezierPath* roundedRect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    
    [[UIColor whiteColor] setFill];
    [roundedRect fill];
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (NSString *)activityTitle
{
    return NSLocalizedString(@"微信好友", nil);
}

@end
