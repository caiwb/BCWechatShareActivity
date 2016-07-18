//
//  BCWXModel.m
//  Pods
//
//  Created by caiwb on 16/7/18.
//
//

#import "BCWXModel.h"

#define NSNullObjects @[@"",@0,@{},@[]]

@interface NSNull (FakeNil)

@end

@implementation NSNull (FakeNil)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature)
    {
        for (NSObject *object in NSNullObjects)
        {
            signature = [object methodSignatureForSelector:aSelector];
            if (!signature)
            {
                continue;
            }
            if (strcmp(signature.methodReturnType, "@") == 0)
            {
                signature = [[NSNull null] methodSignatureForSelector:@selector(bcNil)];
            }
            return signature;
        }
        return [super methodSignatureForSelector:aSelector];
    }
    return signature;
}

- (id)bcNil
{
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    for (NSObject *object in NSNullObjects)
    {
        if ([object respondsToSelector:anInvocation.selector])
        {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    [super forwardInvocation:anInvocation];
}

@end

@implementation BCWXAccessTokenModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation BCWXUserInfo

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end


