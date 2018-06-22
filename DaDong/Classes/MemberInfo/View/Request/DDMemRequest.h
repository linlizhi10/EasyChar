//
//  DDMemRequest.h
//  DaDong
//
//  Created by lin on 2018/3/22.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "Request.h"

@interface DDMemRequest : Request
@property (copy, nonatomic) NSString *shopNo;
@property (copy, nonatomic) NSString *salesNo;
@property (copy, nonatomic) NSString *memberNo;
@property (copy, nonatomic) NSString *memberName;

@end
@interface DDMemDetailRequest : Request
@property (copy, nonatomic) NSString *memberNo;
@end
@interface DDMemLabelRequest : Request
@property (copy, nonatomic) NSString *memberNo;
@end
@interface DDMemCouponRequest : Request
@property (copy, nonatomic) NSString *memberNo;
@end
