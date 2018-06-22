//
//  DDActivityDetailVC.m
//  DaDong
//
//  Created by lin on 2018/3/12.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDActivityDetailVC.h"
#import "ActivityHeaderCell.h"
#import "ActivityDetailCell.h"
#import "DDActivityRequest.h"
#import "DDActivityM.h"
#import "CouponGoodsCell.h"
typedef NS_ENUM(NSInteger, OrderTypeSource) {
    OrderTypeSourceCurrentAscending,
    OrderTypeSourceCurrentDesending,
    OrderTypeSourceLastAscending,
    OrderTypeSourceLastDesending
    
};
@interface DDActivityDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_activityId;
}
@property (assign, nonatomic) OrderTypeSource type;
@property (weak, nonatomic) IBOutlet UITableView *activityDTable;

@property (strong, nonatomic) IBOutlet UIView *headerView;
- (IBAction)expotAction:(id)sender;
- (IBAction)currentPriceAction:(id)sender;
- (IBAction)lastPriceAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *currentPriceBtn;
@property (weak, nonatomic) IBOutlet UIButton *lastPriceBtn;
@property (strong, nonatomic) DDActivityDetailM *detail;

@end

@implementation DDActivityDetailVC
- (instancetype)initWithId:(NSString *)activityId {
    self = [super init];
    if (self) {
        _activityId = activityId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"促销信息";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [_activityDTable registerNib:[UINib nibWithNibName:@"ActivityHeaderCell" bundle:nil] forCellReuseIdentifier:@"cellACH"];
//    [_activityDTable registerNib:[UINib nibWithNibName:@"ActivityDetailCell" bundle:nil] forCellReuseIdentifier:@"cellACD"];
    [_activityDTable registerNib:[UINib nibWithNibName:@"CouponGoodsCell" bundle:nil] forCellReuseIdentifier:@"cellGC"];

    _activityDTable.estimatedRowHeight = 100;
    [self activityDataLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ActivityHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellACH"];
         [cell.icon sd_setImageWithURL:[NSURL URLWithString:_detail.promotionIcon?:@""] placeholderImage:[UIImage imageNamed:@"GRXX-img-tx"]];
        cell.activityContent.text = _detail.remark?:@"暂无";
        cell.name.text = _detail.promotionName?:@"";
//        cell.district.text = [NSString stringWithFormat:@"活动范围:%@",_detail.promotionScope?:@""];
        cell.district.attributedText = [self originalContent:@"活动范围:" differentContent:_detail.promotionScope?:@"暂无"];
        cell.limitTimeA.text = [NSString stringWithFormat:@"活动时间:%@",_detail.limitTime?:@""];
        return cell;
    }else{
        
//        ActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellACD"];
//        DDActivityProductM *product = _detail.productList[indexPath.row];
//        [cell.icon sd_setImageWithURL:[NSURL URLWithString:product.productImg?:@""] placeholderImage:[UIImage imageNamed:@"GRXX-img-tx"]];
//        cell.lastPrice.text = [NSString stringWithFormat:@"￥%@",product.previousPrice?:@""];
//        cell.currentPrice.text = [NSString stringWithFormat:@"本期价:￥%@",product.currentPrice?:@""];
//        cell.goodsNO.text = [NSString stringWithFormat:@"货号:%@",product.artNo?:@""];
//        cell.tips.text = product.skcCode?:@"";
//        return cell;
        CouponGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellGC"];
        //        DDActivityProductM *product = _detail.list[indexPath.row];
        //        [cell.icon sd_setImageWithURL:[NSURL URLWithString:product.productImg?:@""] placeholderImage:[UIImage imageNamed:@"GRXX-img-tx"]];
        //        cell.goodsNO.text = [NSString stringWithFormat:@"货号:%@",product.artNo?:@""];
        return cell;
    }
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
//    return _detail.productList.count;
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 83);
        return _headerView;
    }
    return nil;
}
- (IBAction)expotAction:(id)sender {
    
}

- (IBAction)currentPriceAction:(id)sender {
    
    [_lastPriceBtn setImage:[UIImage imageNamed:@"SPLB-btn-h"] forState:UIControlStateNormal];
    [_lastPriceBtn setTitleColor:RGBCOLORV(0x999999) forState:UIControlStateNormal];

    UIButton *btn = (UIButton *)sender;
    [btn setTitleColor:RGBCOLORV(0xEA5361) forState:UIControlStateNormal];

    if (_type == OrderTypeSourceCurrentAscending) {
        _type = OrderTypeSourceCurrentDesending;
        [btn setImage:[UIImage imageNamed:@"SPLB-btn-x"] forState:UIControlStateNormal];
    }else {
        _type = OrderTypeSourceCurrentAscending;
        [btn setImage:[UIImage imageNamed:@"SPLB-btn-s"] forState:UIControlStateNormal];
    }
}

- (IBAction)lastPriceAction:(id)sender {
    [_currentPriceBtn setImage:[UIImage imageNamed:@"SPLB-btn-h"] forState:UIControlStateNormal];
    [_currentPriceBtn setTitleColor:RGBCOLORV(0x999999) forState:UIControlStateNormal];
    UIButton *btn = (UIButton *)sender;
    [btn setTitleColor:RGBCOLORV(0xEA5361) forState:UIControlStateNormal];
    if (_type == OrderTypeSourceLastAscending) {
        _type = OrderTypeSourceLastDesending;
        [btn setImage:[UIImage imageNamed:@"SPLB-btn-x"] forState:UIControlStateNormal];
    }else {
        _type = OrderTypeSourceLastAscending;
        [btn setImage:[UIImage imageNamed:@"SPLB-btn-s"] forState:UIControlStateNormal];
    }
}
- (void)activityDataLoad{
//    _arrActive = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DDActivityDetailRequest *request = [DDActivityDetailRequest Request];
//    request.promotionCode = @"XPOINT_20180312";
    request.promotionCode = _activityId;
    request.cityCode = @"331100";
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (isSuccess) {
            [WToast showWithTextCenter:@"sucess"];
            DDActivityDetailM *activityM = [DDActivityDetailM objectWithKeyValues:result.data];
            _detail = activityM;
            
            [_activityDTable reloadData];
            
        }else{
            //                [MBProgressHUD showError:result.message toView:self.view];
            [WToast showWithTextCenter:result.message];
        }
    }];
}
- (NSAttributedString *)originalContent:(NSString *)str1 differentContent:(NSString *)str2{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str1?:@""] attributes:@{NSForegroundColorAttributeName:RGBCOLORV(0x999999)}];
    NSAttributedString *strT = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str2?:@""] attributes:@{NSForegroundColorAttributeName:RGBCOLORV(0x666666),NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    [str appendAttributedString:strT];
    return str;
}
@end
