//
//  BCWXBaseActivity.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <UIKit/UIKit.h>
#import "BCWXShareProvider.h"

@interface BCWXBaseActivity : UIActivity

//text is required at least
@property (nonatomic, assign) BCWXShareType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *webUrl;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) NSString *musicWebUrl;
@property (nonatomic, strong) NSString *musicUrl;
@property (nonatomic, strong) NSString *videoWebUrl;
@property (nonatomic, strong) NSData *imageData;

@property (nonatomic, strong) void (^completeBlock)(BOOL suc, NSString *errMsg);
@property (nonatomic, strong) void (^actionBlock)(Class activityClass);


@end
