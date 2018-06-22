//
//  DDMemberInfo.m
//  DaDong
//
//  Created by lin on 2018/3/22.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDMemberInfo.h"

@implementation DDMemberInfo

@end
@implementation DDMemberDetailInfo

@end
@implementation DDMemberLabelInfo

@end
@implementation DDMemberCouponInfo
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"introduce" : @"description"
             };
}
+ (NSString *)propertyKey:(NSString *)propertyName{
    NSString *key;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self replacedKeyFromPropertyName][propertyName];
    }
    return key?:propertyName;
}
@end
