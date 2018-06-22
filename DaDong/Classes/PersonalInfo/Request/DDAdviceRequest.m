//
//  DDAdviceRequest.m
//  DaDong
//
//  Created by lin on 2018/3/20.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDAdviceRequest.h"

@implementation DDAdviceRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/shoprs/feedback";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"shopNo":self.shopNo?:@"",
                                      @"salesNo":self.salesNo?:@"",
                                      @"comment":self.comment?:@""
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
