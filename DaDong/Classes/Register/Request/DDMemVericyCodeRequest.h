//
//  DDMemVericyCodeRequest.h
//  DaDong
//
//  Created by lin on 2018/3/21.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "Request.h"

@interface DDMemVericyCodeRequest : Request
@property (copy, nonatomic) NSString *phone;
@end
@interface DDMemRegisterRequest : Request
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *verification;
@property (copy, nonatomic) NSString *memberName;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *income;
@property (copy, nonatomic) NSString *oftenSize;
@property (copy, nonatomic) NSString *salesNo;
@property (copy, nonatomic) NSString *shopNo;

@end
