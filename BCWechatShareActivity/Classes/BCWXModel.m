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

@interface BCWXModel ()
{
    __strong NSDictionary* _dictionary;
}

@end

@implementation BCWXModel

- (id)initWithDictionary:(NSDictionary *)inDic
{
    Class klass = self.class;
    
    self = [self initWithDictionary:inDic error:nil];
    
    if (!self)
    {
        self = [[klass alloc] init];
    }
    
    return self;
}

- (void)updateWithDictionary:(NSDictionary *)inDic {}

+ (NSMutableArray *)arrayWithDicionaryArray:(NSArray *)inArray
{
    if (! [inArray isKindOfClass:[NSArray class]])
    {
        return nil;
    }
    NSMutableArray* results = [NSMutableArray arrayWithCapacity:inArray.count];
    
    if ([inArray isKindOfClass:[NSArray class]])
    {
        for (int i = 0; i < inArray.count; i ++)
        {
            [results addObject:[[self alloc] initWithDictionary:inArray[i]]];
        }
    }
    
    return results;
}

- (BOOL)autoSetValues
{
    return YES;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}

@end

@implementation BCWXAccessTokenModel

@end

@implementation BCWXUserInfo

@end


