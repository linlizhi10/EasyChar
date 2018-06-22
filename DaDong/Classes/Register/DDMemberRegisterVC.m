//
//  DDMemberRegisterVC.m
//  DaDong
//
//  Created by lin on 2018/2/28.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDMemberRegisterVC.h"
#import "FITextField.h"
@interface DDMemberRegisterVC ()
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScroll;
@property (weak, nonatomic) IBOutlet FITextField *phone;
@property (weak, nonatomic) IBOutlet FITextField *validNO;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
- (IBAction)sendAction:(id)sender;
@property (weak, nonatomic) IBOutlet FITextField *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
- (IBAction)sexAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *date;
- (IBAction)dateAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *income;
- (IBAction)incomeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *commonSize;
@property (weak, nonatomic) IBOutlet UIButton *commonSizeAction;
@property (weak, nonatomic) IBOutlet FITextField *guideNO;
- (IBAction)scanAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)finishAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *dateView;

@end

@implementation DDMemberRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员代注册";
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sendAction:(id)sender {
}
- (IBAction)sexAction:(id)sender {
}
- (IBAction)dateAction:(id)sender {
    _shadowView.hidden = NO;
    _dateView.frame= CGRectMake(0, SCREEN_HEIGHT - 223, SCREEN_WIDTH, 223);
    [self.view addSubview:_dateView];
}
- (IBAction)incomeAction:(id)sender {
}
- (IBAction)scanAction:(id)sender {
}

- (IBAction)cancelAction:(id)sender {
    _shadowView.hidden = YES;
    [_dateView removeFromSuperview];
}

- (IBAction)finishAction:(id)sender {
    _shadowView.hidden = YES;
    [_dateView removeFromSuperview];
    NSLog(@"--%@",_datePicker.date);
}

@end
