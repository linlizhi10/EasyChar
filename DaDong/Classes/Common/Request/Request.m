//
//  Request.m
//  KYiOS
//
//  Created by mini珍 on 15/9/14.
//  Copyright (c) 2015年 mini珍. All rights reserved.
//

#import "Request.h"


@implementation Request

+(id)Request{
    return [[self alloc]initRequest];
}

-(id)initRequest{
    self = [self init];
    if(self){
        [self loadRequest];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if(self){
        [self loadRequest];
    }
    return self;

}
-(void)loadRequest{
    self.params = [NSDictionary dictionary];
    self.requestFiles_Upload = [NSDictionary dictionary];
    self.httpHeaderFields =[NSDictionary dictionary];
}

- (void)startCallBack:(RequestCallBackBlock)_callBack{
    
    //因为请求头加密要用到参数里面的数据，所以每次都要重新加密
    self.httpHeaderFields = @{@"app_token":@"11",
                              @"app_id":@"11",
                              @"format":@"json",
                              @"sign":@"3333",
                              @"timestamp":@"34343",
                              @"topic":@"3333",
                              @"version":@"23423423",
                              @"request_data":@"123123"};
    //
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    //**HTTPS请求专属**
//    manager.securityPolicy = securityPolicy;
    //**

    //请求头
    if (self.httpHeaderFields.count>0) {
        for (NSString * key in self.httpHeaderFields.allKeys) {
            [manager.requestSerializer setValue:[self.httpHeaderFields objectForKey:key] forHTTPHeaderField:key];
        }
    }
    //超时时间
    [manager.requestSerializer setTimeoutInterval:20];
    
    //请求地址
    NSString * url;
    if (self.HOST) {
        url = [NSString stringWithFormat:@"%@%@",self.HOST,self.PATH];
    }else{
        url = [NSString stringWithFormat:@"%@%@",ServerAddressURL,self.PATH];
    }
#ifdef DEBUG
    NSLog(@"\n----RequestURL : %@\n/----Parameters :\n%@\n  -----------",url,self.params);
    NSMutableString * str = [NSMutableString stringWithString:url];
    if (self.params.count>0) {
        for (int i = 0; i<self.params.count; i++) {
            if (i == 0) {
                [str appendString:[NSString stringWithFormat:@"?%@=%@",[self.params.allKeys objectAtIndex:i],[self.params.allValues objectAtIndex:i]]];
            }else{
                [str appendString:[NSString stringWithFormat:@"&%@=%@",[self.params.allKeys objectAtIndex:i],[self.params.allValues objectAtIndex:i]]];
            }
        }
        NSLog(@"\n----RequestURL GET URL \n%@\n  -----------",str);
    }
    //NSLog(@"\n----self.httpHeaderFields : %@",self.httpHeaderFields);
#endif
    //请求正文
    if ([self.METHOD isEqualToString:@"GET"]) {

    }else{
        //需要上传图片流
        if (self.requestFiles_Upload.count >0) {
        }else{
            //纯数据
            
            [manager POST:url parameters:self.params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"res is ---->%@",responseObject);
                NetworkModel *nm = [[NetworkModel alloc] initWithJsonData:responseObject];
                if ([nm.status isEqualToString:@"0"]) {
                    _callBack(YES,nm);
                }else{
                    _callBack(NO,nm);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //
                NSLog(@"error is %@",error);
                NetworkModel *nm = [[NetworkModel alloc] init];
                nm.message = @"网络状况不佳";
                _callBack(NO,nm);
            }];
        }
    }
}


//token失效跳转
//- (void)tokenFaildMethodTipsMessage:(NSString *)message{
//    if ([FIUser shareUser].loginStatus == YES) {
//        //清除user数据
//        [FIUser clearUerInfo];
//        //阿里解绑 
//        [CloudPushSDK unbindAccount:^(CloudPushCallbackResult *res) {
//            //
//        }];
//    }
//    UINavigationController * loginNav = (UINavigationController *)[MainTab shareInstance].presentedViewController;
//
//    if (loginNav && [loginNav isKindOfClass:[FIGestureNavViewController class]]) {
//        [loginNav dismissViewControllerAnimated:YES completion:nil];
//    }
//    
//    
//    UINavigationController * nav = (UINavigationController *)[MainTab shareInstance].selectedViewController;
//
//    if ([MainTab shareInstance].selectedIndex == 0) {
//        [nav popToRootViewControllerAnimated:NO];
//    }else{
//        [nav popToRootViewControllerAnimated:NO];
//        [[MainTab shareInstance]setSelectedIndex:0];
//    }
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"tokenFailed" object:nil];
//    
//    NSString *messageTitle = [NSString stringWithFormat:@"%@",message];
//    
//    //messageTitle == @"您还未登录";
////    if ([messageTitle isEqualToString:@"您还未登录"]) {return;}
//    
//    if ([[UIApplication sharedApplication].keyWindow isKindOfClass:NSClassFromString(@"_UIAlertControllerShimPresenterWindow")]) {
//        NSLog(@"alertView");
//        
//        UIWindow *keyWindow = [MainTab shareInstance].view.window;
//        [UICustomAlert showAlertTitle:nil andExpandMessage:messageTitle andCancelBtn:@"重置密码" andOtherBtn:@"重新登录" andTouchAction:^(NSInteger selectIndex) {
//            if (selectIndex == 1) {
//                [[MainTab shareInstance] showLoginViewWithBlock:^(BOOL isLoginSuccess) {
//                    //
//                }];
//            }else if (selectIndex == 0){
//            [[MainTab shareInstance] showForgetViewWithBlock:^(BOOL isLoginSuccess) {
//                
//            }];
//                
//            }
//        } andSuperShow:keyWindow];
//    }
//    else{
//        [UICustomAlert showAlertTitle:nil andExpandMessage:messageTitle andCancelBtn:@"重置密码" andOtherBtn:@"重新登录" andTouchAction:^(NSInteger selectIndex) {
//            if (selectIndex == 1) {
//                [[MainTab shareInstance] showLoginViewWithBlock:^(BOOL isLoginSuccess) {
//                    //
//                }];
//            }else if (selectIndex == 0){
//                [[MainTab shareInstance] showForgetViewWithBlock:^(BOOL isLoginSuccess) {
//                    
//                }];
//                
//            }
//        } andSuperShow:nil];
//    }
//}

//签名key失效
//- (void)resetSignKeyWith:(NSString *)key{
//    if (key) {
//        dispatch_async(dispatch_get_main_queue(), ^{
////            [FIBaseData share].skey = key;
//             [FISkeyManager share].skey = key;            
//        });
//    }
//}

@end


@implementation NetworkModel

- (instancetype)initWithDictionary : (NSDictionary *)_dictionary{
    self = [super init];
    if (self) {
        NSDictionary * dic = _dictionary;
        self.allDic = _dictionary;
        if (!dic || [dic count] <= 0) {
            self.isJsonError = YES;
            self.status = @"-1";
        }
        else{
            if ([[dic objectForKey:@"response_code"] isEqualToString:@"S000000"]) {
                self.status = @"0";
            }else{
                self.status = [dic objectForKey:@"response_code"];
            }
            self.message = [dic objectForKey:@"response_msg"];
            self.data = [dic objectForKey:@"response_data"];
            if (!self.data && [self.data count] <= 0) {
                self.isNoData = YES;
            }
            else if([self.data isKindOfClass:[NSArray class]]){
                self.isArray = YES;
            }
        }
    }
    return self;
}

- (instancetype)initWithJsonData : (NSDictionary *)_jsonData
{
    NSDictionary *dic = _jsonData;
    if (!dic || [dic count] <= 0) {
        self = [super init];
        self.isJsonError = YES;
        self.status = @"-1";
    }
    else{
        self = [self initWithDictionary:dic];
    }
    return self;
}



@end

