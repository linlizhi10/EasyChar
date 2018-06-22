//
//  OrderInfo.m
//  DaDong
//
//  Created by lin on 2018/3/2.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "OrderInfo.h"

@implementation OrderInfo
+ (NSDictionary *)objectClassInArray{
    return @{@"productImgs" : [NSString class]
            };
}
@end

@implementation OrderProduct

@end

@implementation OrderInfoDetail
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [OrderProduct class]
             };
}
@end
