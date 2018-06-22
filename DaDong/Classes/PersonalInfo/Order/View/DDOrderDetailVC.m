//
//  DDOrderDetailVC.m
//  DaDong
//
//  Created by lin on 2018/3/5.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDOrderDetailVC.h"
#import "OrderDCell.h"
#import "DDOrderRequest.h"
#import "OrderInfo.h"
@interface DDOrderDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_orderNumber;
    
}
@property (weak, nonatomic) IBOutlet UITableView *goodsTable;

@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UILabel *orderType;
@property (weak, nonatomic) IBOutlet UILabel *buyMethod;
@property (weak, nonatomic) IBOutlet UILabel *orderDate;
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *guide;
@property (weak, nonatomic) IBOutlet UILabel *commision;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *deduction;
@property (weak, nonatomic) IBOutlet UILabel *carriage;
@property (weak, nonatomic) IBOutlet UILabel *amountDes;
@property (strong, nonatomic) OrderInfoDetail *detail;
@end

@implementation DDOrderDetailVC
- (instancetype)initWithNo:(NSString *)orderNo{
    self = [super init];
    if (self) {
        _orderNumber = orderNo;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_goodsTable registerNib:[UINib nibWithNibName:@"OrderDCell" bundle:nil] forCellReuseIdentifier:@"cellOrder"];
    _goodsTable.estimatedRowHeight = 102;
    _goodsTable.rowHeight = UITableViewAutomaticDimension;
    [self detailDataLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark
#pragma mark --tabel--

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellOrder"];
    OrderProduct *product = _detail.list[indexPath.row];
    [cell.goodsImage sd_setImageWithURL:[NSURL URLWithString:product.productImg] placeholderImage:nil];
    cell.goodsName.text = product.productName;
    cell.skuInfo.text = [NSString stringWithFormat:@"%@ %@",product.color,product.size];
    cell.price.text = [NSString stringWithFormat:@"￥%@",product.price];
    cell.goodsNumber.text = [NSString stringWithFormat:@"x%@",product.count];
    cell.goodsNO.text = [NSString stringWithFormat:@"x%@",product.artNo];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detail.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 123;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 123);
    return _headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 363;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    _footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 363);
    return _footerView;
}
- (void)fillAmountDesAmount:(NSString *)number price:(NSString *)price{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%@件商品,合计",number?:@""] attributes:@{NSForegroundColorAttributeName:RGBCOLORV(0x1c1c20)}];
    NSAttributedString *strT = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",price?:@""] attributes:@{NSForegroundColorAttributeName:RGBCOLORV(0xed265a)}];
    [str appendAttributedString:strT];
    _amountDes.attributedText =str;
    
}
- (void)detailDataLoad{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DDOrderDetailRequest *request = [DDOrderDetailRequest Request];
    request.orderNo = _orderNumber;
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (isSuccess) {
            if ([result.data isKindOfClass:[NSArray class]]) {
                NSArray *dataA = (NSArray *)result.data;
                NSDictionary *dic = dataA.firstObject;
                OrderInfoDetail *detail = [OrderInfoDetail objectWithKeyValues:dic];
                _detail = detail;
                [self fillContent:detail];
                [_goodsTable reloadData];
            }else{
                OrderInfoDetail *detail = [OrderInfoDetail objectWithKeyValues:result.data];
                _detail = detail;
                [self fillContent:detail];
                [_goodsTable reloadData];
            }
           
        }else{
            //                [MBProgressHUD showError:result.message toView:self.view];
            [WToast showWithTextCenter:result.message];
        }
    }];
}
- (void)fillContent:(OrderInfoDetail *)detail{
    _orderName.text = detail.receiver;
    _phone.text = detail.phone;
    _address.text = detail.receiveAddress;
    _orderNo.text = detail.orderNo;
    _orderType.text = detail.orderType;
    _buyMethod.text = detail.orderChannel;
    _orderDate.text = detail.orderTime;
    _memberName.text = detail.memberName;
    _guide.text = detail.salesName;
    _orderState.text = detail.orderStatus;
    _commision.text = [NSString stringWithFormat:@"￥%@",detail.bonus];
    _price.text = [NSString stringWithFormat:@"￥%@",detail.totalProductPrice];
    _deduction.text = [NSString stringWithFormat:@"￥%@",detail.pointDiscountAmount];
    _carriage.text = [NSString stringWithFormat:@"￥%@",detail.discountTransport];
    [self fillAmountDesAmount:detail.totalProductCount price:detail.totalPayAmount];
}
@end
