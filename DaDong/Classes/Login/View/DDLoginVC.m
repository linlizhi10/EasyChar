//
//  DDLoginVC.m
//  DaDong
//
//  Created by 李传政 on 2018/2/26.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDLoginVC.h"
#import "DDForgetPasswordVC.h"
#import "FITextField.h"
#import "Extention.h"
#import "FILoginRequst.h"
#import "FIUser.h"
#import "DDPersonRequest.h"
#import "ECTodayVC.h"
@interface DDLoginVC ()
@property (weak, nonatomic) IBOutlet FITextField *account;
@property (weak, nonatomic) IBOutlet FITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginBtnAction:(id)sender;
- (IBAction)forgetPassWordBtnAction:(id)sender;
- (IBAction)securityFlagAction:(id)sender;


@end

@implementation DDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    _loginBtn.layer.cornerRadius = 2;
    [_account setContains:11];
    [_password setContains:20];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CustomDelegate
#pragma mark - keybord Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self loginBtnAction:nil];
    return YES;
}
- (IBAction)loginBtnAction:(id)sender {
    [self.view endEditing:YES];
//    if (![Extention phoneNumberValid:_account.text]) {
//        [MBProgressHUD showError:@"请输入合法手机号" toView:self.view];
//        return;
//    }

    if ([[self pureString: _password.text] isEqualToString:@""]) {
//        [MBProgressHUD showError:@"请输入正确的密码" toView:self.view];
        return;
    }


    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FILoginRequst *request = [FILoginRequst Request];
    request.userName = _account.text;
    request.password = _password.text;
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:result.data forKey:@"token"];

            [self getUserInfo];


        }else{
//            [MBProgressHUD showError:result.message toView:self.view];
            [WToast showWithTextCenter:result.message];
        }
    }];

}

- (IBAction)forgetPassWordBtnAction:(id)sender {
    [self.navigationController pushViewController:[DDForgetPasswordVC new] animated:YES];
}

- (IBAction)securityFlagAction:(id)sender {
    _password.secureTextEntry = !_password.secureTextEntry;
    UIButton *btn = (UIButton *)sender;
    NSString *imageName = _password.secureTextEntry?@"pic-yj-off":@"pic-yj";
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (NSString *)pureString:(NSString *)originalString{
    return [originalString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (void)getUserInfo{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    DDPersonRequest *request = [DDPersonRequest Request];
    request.salesNo = @"jack2018";
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            FIUser *userInfo = [FIUser objectWithKeyValues:result.data];
            userInfo.loginStatus = YES;
            [[FIUser shareUser] dataSet:userInfo];
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
            [[NSUserDefaults standardUserDefaults] setObject:userData forKey:@"user"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loginStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [WToast showWithTextCenter:@"登录成功"];
//            [self.navigationController popViewControllerAnimated:YES];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[ECTodayVC new]];
            [nav.navigationBar setBarTintColor:[UIColor whiteColor]];
            nav.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor darkTextColor] forKey:NSForegroundColorAttributeName];
            
            [self.navigationController presentViewController:nav animated:NO completion:nil];
           
        }else{
            [WToast showWithTextCenter:result.message];
        }
    }];
    
}
@end
