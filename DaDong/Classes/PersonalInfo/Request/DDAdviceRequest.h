//
//  DDAdviceRequest.h
//  DaDong
//
//  Created by lin on 2018/3/20.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "Request.h"

@interface DDAdviceRequest : Request
@property (copy, nonatomic) NSString *shopNo;
@property (copy, nonatomic) NSString *salesNo;
@property (copy, nonatomic) NSString *comment;

@end
