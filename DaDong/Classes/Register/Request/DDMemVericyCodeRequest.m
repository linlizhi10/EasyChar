//
//  DDMemVericyCodeRequest.m
//  DaDong
//
//  Created by lin on 2018/3/21.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDMemVericyCodeRequest.h"

@implementation DDMemVericyCodeRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/memberRs/getVerificationCode";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"phone":self.phone?:@""
                                      
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
@implementation DDMemRegisterRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/memberRs/memberRegisterDg";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"phone":self.phone?:@"",
                                      @"verification":self.verification?:@"",
                                      @"memberName":self.memberName?:@"",
                                      @"sex":self.sex?:@"",
                                      @"birthday":self.birthday?:@"",
                                      @"income":self.income?:@"",
                                      @"oftenSize":self.oftenSize?:@"",
                                      @"salesNo":self.salesNo?:@"",
                                      @"shopNo":self.shopNo?:@""

                                      }
                    };
    [super startCallBack:_callBack];
}
@end
