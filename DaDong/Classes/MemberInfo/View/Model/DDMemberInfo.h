//
//  DDMemberInfo.h
//  DaDong
//
//  Created by lin on 2018/3/22.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDMemberInfo : NSObject
@property (copy, nonatomic) NSString *memberName;
@property (copy, nonatomic) NSString *memberNo;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *salesName;
@end
@interface DDMemberDetailInfo : NSObject
@property (copy, nonatomic) NSString *salesName;
@property (copy, nonatomic) NSString *memberNo;
@property (copy, nonatomic) NSString *memberName;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *groupType;
/*
 1）年轻潮流型
 
 2）时尚优质型
 
 3）时尚实惠型
 
 4）品质实惠型
 
 5）价格敏感型
 
 6）综合品质型
 */
@property (copy, nonatomic) NSString *status;
/*
 1）活跃——一个季度内与大东产生3次及以上交互，包括互动平台登录与浏览、购买、参加活动等
 
 2）非活跃——三个月内互动次数为1
 
 3）沉睡——半年内互动次数为0
 
 4）流失——一年内与大东互动次数为0
 
 5）黑名单——盗刷积分、钻空子等违规操作
 */
@property (copy, nonatomic) NSString *memberType;
@property (copy, nonatomic) NSString *buySize;
@property (copy, nonatomic) NSString *point;
@end
@interface DDMemberLabelInfo : NSObject
@property (assign, nonatomic) int labelID;
@property (copy, nonatomic) NSString *labelName;

@end
@interface DDMemberCouponInfo : NSObject
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *introduce;
@property (copy, nonatomic) NSString *useTime;
@property (copy, nonatomic) NSString *activeRemark;

@end
