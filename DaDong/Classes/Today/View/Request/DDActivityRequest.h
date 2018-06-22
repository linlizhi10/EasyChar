//
//  DDActivityRequest.h
//  DaDong
//
//  Created by lin on 2018/3/20.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "Request.h"

@interface DDActivityRequest : Request
@property (copy, nonatomic) NSString *shopID;
@end
@interface DDActivityDetailRequest : Request
@property (copy, nonatomic) NSString *promotionCode;
//cityCode
@property (copy, nonatomic) NSString *cityCode;
@end
