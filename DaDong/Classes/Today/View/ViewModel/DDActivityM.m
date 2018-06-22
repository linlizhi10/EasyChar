//
//  DDActivityM.m
//  DaDong
//
//  Created by lin on 2018/3/20.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDActivityM.h"

@implementation DDActivityM
- (NSString *)limitTime{

    return [NSString stringWithFormat:@"%@-%@",self.startDate,self.endDate];
}
@end
@implementation DDActivityProductM

@end
@implementation DDActivityDetailM
- (NSString *)limitTime{
    
    return [NSString stringWithFormat:@"%@-%@",self.startDate,self.endDate];
}
+ (NSDictionary *)objectClassInArray{
    return @{@"productList" : [DDActivityProductM class]};
}
@end
