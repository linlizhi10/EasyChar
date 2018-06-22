//
//  DDOrderRequest.h
//  DaDong
//
//  Created by lin on 2018/3/19.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "Request.h"

@interface DDOrderRequest : Request
@property (nonatomic, copy) NSString *shopNo; //
@property (nonatomic, copy) NSString *salesNo; //
@property (nonatomic, copy) NSString *orderStatus; //
@property (nonatomic, copy) NSString *orderSource; //
@property (nonatomic, copy) NSString *isBonus; //
@property (nonatomic, copy) NSString *startDate; //
@property (nonatomic, copy) NSString *endDate; //

@end
@interface DDOrderDetailRequest : Request
@property (nonatomic, copy) NSString *orderNo; //

@end
