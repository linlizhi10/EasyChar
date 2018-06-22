//
//  DDPersonRequest.m
//  DaDong
//
//  Created by lin on 2018/3/20.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDPersonRequest.h"

@implementation DDPersonRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/shoprs/findSalesmanInfo";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{
                                      @"salesNo":self.salesNo?:@"",
                                      
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
