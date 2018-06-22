//
//  DDRegisterSVC.m
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDRegisterSVC.h"

@interface DDRegisterSVC ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *workNO;
- (IBAction)backToAction:(id)sender;

@end

@implementation DDRegisterSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册完成";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backToAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
