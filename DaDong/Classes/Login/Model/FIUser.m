//
//  FIUser.m
//  finance
//
//  Created by 汤军 on 17/5/8.
//  Copyright © 2017年 李传政. All rights reserved.
//

#import "FIUser.h"

@implementation FIUser
static FIUser *user = nil;
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"userTypeT" : @"userType"
             };
}
+ (NSString *)propertyKey:(NSString *)propertyName{
    NSString *key;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self replacedKeyFromPropertyName][propertyName];
    }
    return key?:propertyName;
}
- (id)init{
    self = [super init];
    if (self) {

        self.phone = @""; //手机号
        
        self.userType = UserTypeVisiter;
    }
    return self;
}
+ (instancetype)shareUser{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[FIUser alloc] init];
    });
    return user;
}

- (void)dataSet:(FIUser *)user{
    [FIUser shareUser].phone = user.phone;
    [FIUser shareUser].loginStatus = user.loginStatus;
    [FIUser shareUser].salesName = user.salesName;
    [FIUser shareUser].salesNo = user.salesNo;
    [FIUser shareUser].shopName = user.shopName;
    [FIUser shareUser].serviceLvL = user.serviceLvL;
    [FIUser shareUser].exclusiveMemberNum = user.exclusiveMemberNum;
    [FIUser shareUser].imgUrl = user.imgUrl;
    [FIUser shareUser].qrCode = user.qrCode;
    [FIUser shareUser].shopAddress = user.shopAddress;
    [FIUser shareUser].role = user.role;
    [FIUser shareUser].longitude = user.longitude;
    [FIUser shareUser].latitude = user.latitude;
    
}
+ (void)clearUerInfo{
//    [FIUser shareUser].phone = @"";
    [FIUser shareUser].loginStatus = NO;
    [FIUser shareUser].phone = @"";
    [FIUser shareUser].salesName = @"";
    [FIUser shareUser].salesNo = @"";
    [FIUser shareUser].shopName = @"";
    [FIUser shareUser].serviceLvL = @"";
    [FIUser shareUser].exclusiveMemberNum = @"";
    [FIUser shareUser].imgUrl = @"";
    [FIUser shareUser].qrCode = @"";
    [FIUser shareUser].shopAddress = @"";
    [FIUser shareUser].longitude = @"";
    [FIUser shareUser].latitude = @"";
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loginStatus"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    [[NSNotificationCenter defaultCenter] postNotificationName:UserLogOutNotification object:nil];
}
@end
