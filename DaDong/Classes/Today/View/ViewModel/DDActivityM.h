//
//  DDActivityM.h
//  DaDong
//
//  Created by lin on 2018/3/20.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDActivityM : NSObject
@property (copy, nonatomic) NSString *promotionIcon;
@property (copy, nonatomic) NSString *promotionCode;
@property (copy, nonatomic) NSString *promotionName;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *endDate;
@property (copy, nonatomic) NSString *limitTime;
@end

@interface DDActivityProductM : NSObject
@property (copy, nonatomic) NSString *productImg;
@property (copy, nonatomic) NSString *previousPrice;
@property (copy, nonatomic) NSString *currentPrice;
@property (copy, nonatomic) NSString *artNo;
@property (copy, nonatomic) NSString *skcCode;

@end

@interface DDActivityDetailM : NSObject
@property (copy, nonatomic) NSString *promotionIcon;
@property (copy, nonatomic) NSString *promotionScope; //活动范围
@property (copy, nonatomic) NSString *promotionName;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *endDate;
@property (copy, nonatomic) NSString *limitTime;
@property (strong, nonatomic) NSArray<DDActivityProductM *> *productList;

@end
