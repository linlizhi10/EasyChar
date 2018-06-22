//
//  DDMemberRegisterVC.m
//  DaDong
//
//  Created by lin on 2018/2/28.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDMemberRegisterVC.h"
#import "FITextField.h"
#import "SizeInfo.h"
#import "IncomeInfo.h"
#import "SizeChooseCell.h"
#import "IncomeCell.h"
#import "DDCommonScanVC.h"
#import "DDRegisterSVC.h"
#import "DDMemVericyCodeRequest.h"
#import "Extention.h"
#import "NSTimer+BlockTimer.h"
@interface DDMemberRegisterVC ()
<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UIView *shadowView;
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


- (IBAction)commonSizeAction:(id)sender;
@property (weak, nonatomic) IBOutlet FITextField *guideNO;
- (IBAction)scanAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)finishAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *sexView;

@property (weak, nonatomic) IBOutlet UIImageView *girlCheck;
@property (weak, nonatomic) IBOutlet UIImageView *maleCheck;
- (IBAction)sexCloseAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (strong, nonatomic) NSMutableArray *arrMMM;
- (IBAction)girlA:(id)sender;
- (IBAction)maleA:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *sizeView;
@property (weak, nonatomic) IBOutlet UITableView *sizeTable;
- (IBAction)sizeFinishA:(id)sender;
- (IBAction)sizeCancelA:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *incomeView;

- (IBAction)incomeCloseA:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *incomeTable;
@property (strong, nonatomic) NSMutableArray *arrMMMM;
- (IBAction)uploadA:(id)sender;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int count;

@end

@implementation DDMemberRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员代注册";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0.7;
    
     [_sizeTable registerNib:[UINib nibWithNibName:@"SizeChooseCell" bundle:nil] forCellReuseIdentifier:@"cellSize"];
    [_incomeTable registerNib:[UINib nibWithNibName:@"IncomeCell" bundle:nil] forCellReuseIdentifier:@"cellIncome"];
    _arrMMM = [[NSMutableArray alloc] init];
    _arrMMMM = [[NSMutableArray alloc] init];
    for (int i = 34; i<46; i ++) {
        SizeInfo *sizeInfo = [[SizeInfo alloc] init];
        sizeInfo.selected = NO;
        sizeInfo.size = [NSString stringWithFormat:@"%d码",i];
        [_arrMMM addObject:sizeInfo];
    }
    for (int i = 0; i<4; i ++) {
        IncomeInfo *inInfo = [[IncomeInfo alloc] init];
        inInfo.selected = NO;
        if (i == 0) {
            inInfo.income = @"0-2000";
        }else if (i == 1) {
            inInfo.income = @"2000-5000";
        }else if (i == 2) {
            inInfo.income = @"5000-10000";
        }else{
            inInfo.income = @"10000以上";
        }
        [_arrMMMM addObject:inInfo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _sizeTable) {
        return _arrMMM.count;

    }else if(tableView == _incomeTable){
        return 4;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _sizeTable) {

    SizeChooseCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"cellSize"];
    SizeInfo *info = _arrMMM[indexPath.row];
    NSString *imageN = (info.selected)?@"CLGC-icon-finsh":@"WLXX-img-yuanquan";
    productCell.chooseFlag.image = [UIImage imageNamed:imageN];
    productCell.sizeN.text = info.size;
    return productCell;
    }else if(tableView == _incomeTable){
        IncomeCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"cellIncome"];
        IncomeInfo *info = _arrMMMM[indexPath.row];
        productCell.checkFlag.hidden = (info.selected)?NO:YES;
        productCell.incomeC.text = info.income;
        return productCell;
        
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _sizeTable) {
        SizeChooseCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        SizeInfo *info = [_arrMMM objectAtIndex:indexPath.row];
        info.selected = !info.selected;
        NSString *imageN = (info.selected)?@"CLGC-icon-finsh":@"WLXX-img-yuanquan";
        cell.chooseFlag.image = [UIImage imageNamed:imageN];
    }else if (tableView == _incomeTable){
//        IncomeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        IncomeInfo *info = [_arrMMMM objectAtIndex:indexPath.row];
        for (IncomeInfo *infoM in _arrMMMM) {
            infoM.selected = NO;
        }
        info.selected = YES;
        _income.text = info.income;
        [self incomeCloseA:nil];

//        [tableView reloadData];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self incomeCloseA:nil];
//
//        });
    }
    
}

- (IBAction)sendAction:(id)sender {
    [self.view endEditing:YES];
    if ([Extention phoneNumberValid:_phone.text]) {
        //倒计时
        [self initTimer];
        DDMemVericyCodeRequest *request = [DDMemVericyCodeRequest Request];
        request.phone = _phone.text;
        [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
            if (isSuccess) {
                [WToast showWithTextCenter:@"短信验证码发送成功"];
                //                [MBProgressHUD showSuccess:@"短信验证码发送成功" toView:self.view];
            }else{
                //                [MBProgressHUD showError:result.message toView:self.view];
                [WToast showWithTextCenter:@"短信验证码发送失败"];
                [self verifyButtonRecover];
            }
        }];
    }else{
        //        _phone.textColor = [UIColor redColor];
        //        [MBProgressHUD showError:@"请输入正确的手机号" toView:self.view];
        NSLog(@"----error");
    }
}

- (void)initTimer{
    _count = 10;
    _sendBtn.enabled = NO;
    __weak typeof(&*self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^{
        __strong typeof(&*self) strongSelf = weakSelf;
        [strongSelf startCounting];
    } repeats:YES];
}

- (void)verifyButtonRecover{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [_sendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _sendBtn.enabled = YES;
    _count = 10;
}

- (void)startCounting{
    if (_count == 1) {
        [self verifyButtonRecover];
    } else {
        _count--;
        //        _validButton.enabled = NO;
        [_sendBtn setTitle:[NSString stringWithFormat:@"%ds",_count] forState:UIControlStateNormal];
        
    }
}

- (IBAction)sexAction:(id)sender {
    [self.view endEditing:YES];

    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    _sexView.frame= CGRectMake(0, SCREEN_HEIGHT - 126, SCREEN_WIDTH, 126);
    [[UIApplication sharedApplication].keyWindow addSubview:_sexView];
}
#pragma mark - date
- (IBAction)dateAction:(id)sender {
    [self.view endEditing:YES];

    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    _dateView.frame= CGRectMake(0, SCREEN_HEIGHT - 223, SCREEN_WIDTH, 223);
    [[UIApplication sharedApplication].keyWindow addSubview:_dateView];
}
- (IBAction)cancelAction:(id)sender {
    [_shadowView removeFromSuperview];
    [_dateView removeFromSuperview];
}

- (IBAction)finishAction:(id)sender {
    [_shadowView removeFromSuperview];
    [_dateView removeFromSuperview];
    NSLog(@"--%@",_datePicker.date);
    _date.text = [self toYearMonthString:_datePicker.date];
}

- (IBAction)scanAction:(id)sender {
    [self.view endEditing:YES];
    DDCommonScanVC * vc = [[DDCommonScanVC alloc]init];
    vc.ptitle = @"导购编号";
    vc.ptitle = @"扫码下单";
    vc.scanBlock = ^(NSString * scanResult){
        NSLog(@"扫描结果是 %@",scanResult);
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - size
- (IBAction)commonSizeAction:(id)sender {
    [self.view endEditing:YES];

    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    _sizeView.frame= CGRectMake(0, SCREEN_HEIGHT - 400, SCREEN_WIDTH, 400);
    [[UIApplication sharedApplication].keyWindow addSubview:_sizeView];
}
- (IBAction)sizeFinishA:(id)sender {
    [_shadowView removeFromSuperview];
    [_sizeView removeFromSuperview];
}

- (IBAction)sizeCancelA:(id)sender {
    [_shadowView removeFromSuperview];
    [_sizeView removeFromSuperview];
    NSLog(@"choose size");
}

- (IBAction)incomeAction:(id)sender {
    [self.view endEditing:YES];

    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    _incomeView.frame= CGRectMake(0, SCREEN_HEIGHT - 220, SCREEN_WIDTH, 220);
    [[UIApplication sharedApplication].keyWindow addSubview:_incomeView];
}
- (IBAction)incomeCloseA:(id)sender {
    [_shadowView removeFromSuperview];
    [_incomeView removeFromSuperview];
}

- (IBAction)girlA:(id)sender {
    _girlCheck.hidden = NO;
    _maleCheck.hidden = YES;
    [self sexCloseAction:nil];
    _sex.text = @"女";

}

- (IBAction)maleA:(id)sender {
    _girlCheck.hidden = YES;
    _maleCheck.hidden = NO;
    [self sexCloseAction:nil];
    _sex.text = @"男";
}
- (IBAction)sexCloseAction:(id)sender {
    [_shadowView removeFromSuperview];
    [_sexView removeFromSuperview];
}
- (IBAction)uploadA:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DDMemRegisterRequest *request = [DDMemRegisterRequest Request];
    request.phone = _phone.text;
    request.verification = _validNO.text;
    request.memberName = _name.text;
    request.sex = _sex.text;
    request.birthday = _date.text;
    request.income = _income.text;
    request.salesNo = _guideNO.text;
    request.shopNo = @"";
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
          
            [self.navigationController pushViewController:[DDRegisterSVC new] animated:YES];

            
        }else{
            [WToast showWithTextCenter:result.message];        }
    }];
}
- (NSString *)toYearMonthString:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *string = [formatter stringFromDate:date];
    return string;
}
@end
