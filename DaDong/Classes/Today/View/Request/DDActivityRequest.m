//
//  DDActivityRequest.m
//  DaDong
//
//  Created by lin on 2018/3/20.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDActivityRequest.h"

@implementation DDActivityRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/promors/promolist";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"shopID":self.shopID?:@"",
                                     
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
@implementation DDActivityDetailRequest
- (void)startCallBack:(RequestCallBackBlock)_callBack{
    self.PATH = @"/promors/promodetail";
    self.METHOD = @"POST";
    self.params = @{
                    @"request_data":@{@"promotionCode":self.promotionCode?:@""
                                      
                                      }
                    };
    [super startCallBack:_callBack];
}
@end
