//
//  DDOrderVCViewController.m
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDOrderVCViewController.h"
#import "OrderCell.h"
#import "OrderInfo.h"
#import "DDOrderDetailVC.h"
#import "DDTransInfoVC.h"
#import "DDOrderRequest.h"
#import <MBProgressHUD.h>
#import "WToast.h"
@interface DDOrderVCViewController ()<UITableViewDelegate,UITableViewDataSource,StateOrderClickDelegate>
@property (strong, nonatomic)  UIView *shadowView;

- (IBAction)orderStateAction:(id)sender;

- (IBAction)dismissBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *coverView;
- (IBAction)topBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipViewLeftMargin;
@property (weak, nonatomic) IBOutlet UITableView *orderTable;
@property (strong, nonatomic) NSMutableArray *arrMMm;
@property (strong, nonatomic) IBOutlet UIButton *selfRightBtn;
- (IBAction)commisionAction:(id)sender;
- (IBAction)startDateAction:(id)sender;
- (IBAction)endDateAction:(id)sender;
- (IBAction)selectionFinishAction:(id)sender;
- (IBAction)resetAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *dateView;
- (IBAction)dateCancleAction:(id)sender;
- (IBAction)dateFinishAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (assign , nonatomic) NSOrderType orderType;
@property (strong, nonatomic) NSMutableArray *selectBtnA;
@property (strong, nonatomic) NSMutableArray *selectBtnB;
@property (assign, nonatomic) BOOL startDateFlag;
@property (copy, nonatomic) NSString *startDate;
@property (copy, nonatomic) NSString *endDate;

@end

@implementation DDOrderVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0.7;
    
    [self setRightBtn];
    [_orderTable registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"cellO"];
    _orderTable.estimatedRowHeight = 44;
    _orderTable.rowHeight = UITableViewAutomaticDimension;
    _selectBtnA = [[NSMutableArray alloc] init];
    _selectBtnB = [[NSMutableArray alloc] init];

//    for (int i = 0; i<3; i ++) {
//        OrderInfo *info = [[OrderInfo alloc] init];
//        info.bonus = @"1.2";
//        [_arrMMm addObject:info];
//    }
    [self dataLoad];
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
    
    return _arrMMm.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *productCell = [_orderTable dequeueReusableCellWithIdentifier:@"cellO"];
    OrderInfo *orderInfo = _arrMMm[indexPath.row];
    productCell.type = _orderType;
    productCell.delegate = self;
    [productCell fillCellWith:orderInfo];
    return productCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderInfo *orderInfo = _arrMMm[indexPath.row];

    DDOrderDetailVC *orderD = [[DDOrderDetailVC alloc] initWithNo:orderInfo.orderNo];
    [self.navigationController pushViewController:orderD animated:YES];
}

- (void)clickSatateAction:(OrderCell *)cell{
    [self.navigationController pushViewController:[DDTransInfoVC new] animated:YES];
    
}

- (IBAction)topBtnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    _orderType = btn.tag;
    _tipViewLeftMargin.constant = (SCREEN_WIDTH / 4)*(btn.tag);
    [_orderTable reloadData];
    [self.view setNeedsLayout];
    [self.view updateConstraints];
    [self dataLoad];
}
- (void)setRightBtn{
    
    UIBarButtonItem  *barBut = [[UIBarButtonItem alloc]initWithCustomView:self.selfRightBtn];
    [self.selfRightBtn addTarget:self
                          action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barBut;
    
}
-(void)rightBtnAction:(UIButton *)btn{
    _coverView.frame= CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[UIApplication sharedApplication].keyWindow addSubview:_coverView];
    
}
- (IBAction)orderStateAction:(id)sender {
    if (_selectBtnA.count > 0) {
        UIButton *btnF = _selectBtnA.firstObject;
        [btnF setBackgroundColor:RGBCOLORV(0xe7e7e7)];
        btnF.selected = NO;
        [_selectBtnA removeAllObjects];
    }
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    [btn setBackgroundColor:RGBCOLORV(0xea5361)];
    [_selectBtnA addObject:btn];
}

- (IBAction)dismissBtnAction:(id)sender {
    [_coverView removeFromSuperview];
}

- (IBAction)commisionAction:(id)sender {
    if (_selectBtnB.count > 0) {
        UIButton *btnF = _selectBtnB.firstObject;
        [btnF setBackgroundColor:RGBCOLORV(0xe7e7e7)];
        btnF.selected = NO;
        [_selectBtnB removeAllObjects];
    }
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    [btn setBackgroundColor:RGBCOLORV(0xea5361)];
    [_selectBtnB addObject:btn];
}

- (IBAction)startDateAction:(id)sender {
    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    _dateView.frame= CGRectMake(0, SCREEN_HEIGHT - 223, SCREEN_WIDTH, 223);
    [[UIApplication sharedApplication].keyWindow addSubview:_dateView];
    _startDateFlag = YES;
}

- (IBAction)endDateAction:(id)sender {
    [[UIApplication sharedApplication].keyWindow addSubview:_shadowView];
    _dateView.frame= CGRectMake(0, SCREEN_HEIGHT - 223, SCREEN_WIDTH, 223);
    [[UIApplication sharedApplication].keyWindow addSubview:_dateView];
    _startDateFlag = NO;
}

- (IBAction)selectionFinishAction:(id)sender {
    [self dismissBtnAction:nil];
    [self dataLoad];
}

- (IBAction)resetAction:(id)sender {
    UIButton *btnF = _selectBtnA.firstObject;
    [btnF setBackgroundColor:RGBCOLORV(0xe7e7e7)];
    btnF.selected = NO;
    UIButton *btnFF = _selectBtnB.firstObject;
    [btnFF setBackgroundColor:RGBCOLORV(0xe7e7e7)];
    btnFF.selected = NO;
    [_selectBtnA removeAllObjects];
    [_selectBtnB removeAllObjects];
    
}
- (IBAction)dateCancleAction:(id)sender {
    [_shadowView removeFromSuperview];
    [_dateView removeFromSuperview];
}

- (IBAction)dateFinishAction:(id)sender {
    [_shadowView removeFromSuperview];
    [_dateView removeFromSuperview];
    NSLog(@"start is %@",_datePicker.date);
    if (_startDateFlag) {
        
    }
}
- (void)dataLoad{
    //    //先下：LS  线上：WX  代客下单：DG
    _arrMMm = [[NSMutableArray alloc] init];

    NSString *orderSource = @"";
    switch (_orderType) {
        case 1:
            orderSource = @"DG";
            break;
        case 2:
            orderSource = @"WX";
            break;
        case 3:
            orderSource = @"LS";
            break;
        default:
            break;
    }
    
    NSString *orderStatus = @"";
    if (_selectBtnA.count>0) {
        UIButton *btnA = _selectBtnA.firstObject;
        orderStatus = [NSString stringWithFormat:@"%ld",btnA.tag - 100];
    }
    NSString *isBonus = @"";
    if (_selectBtnB.count>0) {
        UIButton *btnA = _selectBtnB.firstObject;
        isBonus = [NSString stringWithFormat:@"%ld",btnA.tag - 1000];
    }
    /*
     endDate = "";
     isBonus = "";
     orderSource = "";
     orderStatus = "";
     salesNo = dg002;
     shopNo = 00195;
     startDate = "";
     */
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DDOrderRequest *request = [DDOrderRequest Request];
    request.shopNo = @"00195";
    request.salesNo = @"dg002";
    request.orderSource = orderSource;
    request.orderStatus = orderStatus;
    request.isBonus = isBonus;
    
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (isSuccess) {
            NSLog(@"data is %@",result.data);
            if (result.isArray) {
                for (id obj in result.data) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        OrderInfo *infoO = [OrderInfo objectWithKeyValues:obj];
                        [_arrMMm addObject:infoO];
                    }
                }
            }
            
            [_orderTable reloadData];
        }else{
            //                [MBProgressHUD showError:result.message toView:self.view];
            [WToast showWithTextCenter:result.message];
        }
    }];
}
@end
