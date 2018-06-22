//
//  DDMemRequest.m
//  DaDong
//
//  Created by lin on 2018/3/22.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDMemRequest.h"

@implementation DDMemRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/memberRs/memberList";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"shopNo":self.shopNo?:@"",
                                      @"salesNo":self.salesNo?:@"",
                                      @"memberNo":self.memberNo?:@"",
                                      @"memberName":self.memberName?:@""
                                      }
                    };
    [super startCallBack:_callBack];
}
@end

@implementation DDMemDetailRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/memberRs/memberInfo";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"memberNo":self.memberNo?:@""
                                      
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
@implementation DDMemLabelRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/memberRs/findMemberLabels";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"memberNo":self.memberNo?:@""
                                      
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
@implementation DDMemCouponRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/memberRs/memberCoupon";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"memberNo":self.memberNo?:@""
                                      
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
