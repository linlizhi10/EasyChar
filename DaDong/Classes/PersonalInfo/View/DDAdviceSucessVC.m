//
//  DDAdviceSucessVC.m
//  DaDong
//
//  Created by lin on 2018/3/5.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDAdviceSucessVC.h"

@interface DDAdviceSucessVC ()

@end

@implementation DDAdviceSucessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提示";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
