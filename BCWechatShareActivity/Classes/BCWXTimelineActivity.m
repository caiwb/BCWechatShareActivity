//
//  BCWXTimelineActivity.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCWXTimelineActivity.h"

@implementation BCWXTimelineActivity

- (id)init
{
    if (self = [super init])
    {
        self.type = BCWX_TIMELINE;
    }
    return self;
}

- (UIImage *)activityImage
{
    UIImage *image = [UIImage imageNamed:@"wechat_timeline_icon"];
    
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
    return NSLocalizedString(@"微信朋友圈", nil);
}

@end
