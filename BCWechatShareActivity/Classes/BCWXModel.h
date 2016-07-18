//
//  BCWXModel.h
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import <JSONModel/JSONModel.h>

@interface BCWXAccessTokenModel : JSONModel

@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *refresh_token;
@property (nonatomic, strong) NSString *openid;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, assign) int expires_in;

@property (nonatomic, strong) NSString *errcode;
@property (nonatomic, strong) NSString *errmsg;

@end

@interface BCWXUserInfo : JSONModel

@property (nonatomic, strong) NSString *openid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, assign) int sex;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *headimgurl;
@property (nonatomic, strong) NSArray<NSString *> *privilege;
@property (nonatomic, strong) NSString *unionid;

@property (nonatomic, strong) NSString *errcode;
@property (nonatomic, strong) NSString *errmsg;


@end
