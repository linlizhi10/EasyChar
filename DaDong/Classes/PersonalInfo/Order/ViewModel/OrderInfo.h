//
//  OrderInfo.h
//  DaDong
//
//  Created by lin on 2018/3/2.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject
@property (copy, nonatomic) NSString *orderNo;
@property (copy, nonatomic) NSString *orderStatus;
@property (copy, nonatomic) NSString *orderType;
@property (copy, nonatomic) NSString *memberName;
@property (copy, nonatomic) NSString *bonus;
@property (strong, nonatomic) NSArray<NSString *> *productImgs;
@property (copy, nonatomic) NSString *orderTime;
@property (copy, nonatomic) NSString *productTotalCount;
@property (copy, nonatomic) NSString *totalPayAmount;

@end
@interface OrderProduct : NSObject
@property (copy, nonatomic) NSString *productImg;
@property (copy, nonatomic) NSString *productName;
@property (copy, nonatomic) NSString *color;
@property (copy, nonatomic) NSString *size;
@property (copy, nonatomic) NSString *artNo;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *count;

@end
@interface OrderInfoDetail : NSObject
@property (copy, nonatomic) NSString *orderNo;
@property (copy, nonatomic) NSString *orderStatus;
@property (copy, nonatomic) NSString *orderType;
@property (copy, nonatomic) NSString *memberName;
@property (copy, nonatomic) NSString *orderChannel;
@property (copy, nonatomic) NSString *salesName;
@property (copy, nonatomic) NSString *orderTime;
@property (copy, nonatomic) NSString *bonus;

@property (copy, nonatomic) NSString *receiver;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *receiveAddress;

@property (copy, nonatomic) NSString *totalProductPrice;
@property (copy, nonatomic) NSString *pointDiscountAmount;//东币抵扣
@property (copy, nonatomic) NSString *discountTransport;//运费
@property (copy, nonatomic) NSString *totalProductCount;
@property (copy, nonatomic) NSString *totalPayAmount; //实付款
@property (copy, nonatomic) NSString *coupDiscountAmount;//优惠券抵扣金额
@property (copy, nonatomic) NSString *promoPrice;//促销活动优惠金额

@property (strong, nonatomic) NSArray<OrderProduct *> *list;

@end
