//
//  DDOrderRequest.m
//  DaDong
//
//  Created by lin on 2018/3/19.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDOrderRequest.h"

@implementation DDOrderRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/orderRs/orderListDg";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"shopNo":self.shopNo?:@"",
                                      @"salesNo":self.salesNo?:@"",
                                      @"orderStatus":self.orderStatus?:@"",
                                      @"orderSource":self.orderSource?:@"",
                                      @"isBonus":self.isBonus?:@"",
                                      @"startDate":self.startDate?:@"",
                                      @"endDate":self.endDate?:@""
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
@implementation DDOrderDetailRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/orderRs/orderDetailsDg";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"orderNo":self.orderNo?:@"",
                                      
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
