//
//  DDTransInfoVC.m
//  DaDong
//
//  Created by lin on 2018/3/6.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDTransInfoVC.h"
#import "TranInfoCell.h"
#import "TransDetailCell.h"
@interface DDTransInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *transInfoTable;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroll;
@property (weak, nonatomic) IBOutlet UIScrollView *btnScroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation DDTransInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流信息";
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self fillCellBtn];
    [_transInfoTable registerNib:[UINib nibWithNibName:@"TranInfoCell" bundle:nil] forCellReuseIdentifier:@"cellT"];
     [_transInfoTable registerNib:[UINib nibWithNibName:@"TransDetailCell" bundle:nil] forCellReuseIdentifier:@"cellTD"];
    _transInfoTable.estimatedRowHeight = 120;
    self.address.text = @"测试地址测试";
//    _transInfoTable.estimatedSectionHeaderHeight = 0;
//    _transInfoTable.estimatedSectionFooterHeight = 10;
    _transInfoTable.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark --tabel--

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TranInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellT"];
        return cell;
    }else{
        TransDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTD"];
        if (indexPath.row == 0) {
            cell.topItemView.hidden = NO;
            cell.normalItemView.hidden = YES;
            cell.lastItemView.hidden = YES;
            
        }else if (indexPath.row == 2){
            cell.topItemView.hidden = YES;
            cell.normalItemView.hidden = YES;
            cell.lastItemView.hidden = NO;
            
        }else{
            cell.topItemView.hidden = YES;
            cell.normalItemView.hidden = NO;
            cell.lastItemView.hidden = YES;
            
        }
        return cell;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (void)fillCellBtn{
    CGFloat btnW = (SCREEN_WIDTH - 40) / 3;
    CGFloat btnH = 33;
    for (int i = 0; i<3; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + (10 + btnW)*i, 4, btnW, btnH);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:RGBCOLORV(0xea5361) forState:UIControlStateSelected];
        [btn setTitleColor:RGBCOLORV(0x4d4d4d) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.borderWidth = 0.5;
        [btn setTitle:[NSString stringWithFormat:@"订单%d",i] forState:UIControlStateNormal];
        btn.layer.borderColor = RGBCOLORV(0x999999).CGColor;
        [_btnScroll addSubview:btn];
    }
}
@end
