//
//  OrderCell.m
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "OrderCell.h"
#import "OrderInfo.h"
@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)stateBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickSatateAction:)]) {
        [self.delegate clickSatateAction:self];
    }
}
- (void)setType:(NSOrderType)type{
    _type = type;
    if (_type == NSOrderTypeAll) {
        _customerName.text = @"订单类型";
    }else{
        _customerName.text = @"客户名";
    }
}
- (void)fillCellWith:(OrderInfo *)orInfo{
   
    NSString *commissionT = @"提成:暂无";
    if ([orInfo.bonus floatValue] < 0) {
        _commission.text = commissionT;
        
    }else{
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"提成:" attributes:@{NSForegroundColorAttributeName:RGBCOLORV(0x1c1c20)}];
        NSAttributedString *strT = [[NSAttributedString alloc] initWithString:orInfo.bonus?:@"" attributes:@{NSForegroundColorAttributeName:RGBCOLORV(0xed265a)}];
        [str appendAttributedString:strT];
        _commission.attributedText =str;
    }
    _orderNo.text = [NSString stringWithFormat:@"编号:%@",orInfo.orderNo];
    if ([orInfo.orderType isEqualToString:@"0"]) {
        _customerName.text = [NSString stringWithFormat:@"订单类型:%@",orInfo.orderType];
    }else{
        _customerName.text = [NSString stringWithFormat:@"客户名:%@",orInfo.memberName];
        
    }
    _orderTime.text = [NSString stringWithFormat:@"下单时间:%@",orInfo.orderTime];
    _goodsNumber.text = [NSString stringWithFormat:@"共%@件商品，实付金额",orInfo.productTotalCount];
    _money.text = [NSString stringWithFormat:@"￥%@",orInfo.totalPayAmount];
    if ([orInfo.orderStatus isEqualToString:@"0"] ) {
        _state.text = @"待收货";
        _state.textColor = RGBCOLORV(0xe85462);
        _righA.hidden = NO;
    }else{
        _state.text = @"已完成";
        _state.textColor = RGBCOLORV(0x5ebb3);
        _righA.hidden = YES;
    }
}
@end
