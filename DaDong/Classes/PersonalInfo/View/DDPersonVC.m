//
//  DDPersonVC.m
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDPersonVC.h"
#import "PHeadCell.h"
#import "PContentCell.h"
#import "DDMQRCode.h"
#import "DDAdviceVC.h"
#import "DDOrderVCViewController.h"
#import "FIUser.h"
@interface DDPersonVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *personTable;

@end

@implementation DDPersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_personTable registerNib:[UINib nibWithNibName:@"PHeadCell" bundle:nil] forCellReuseIdentifier:@"cellph"];
    [_personTable registerNib:[UINib nibWithNibName:@"PContentCell" bundle:nil] forCellReuseIdentifier:@"cellpc"];
    _personTable.estimatedRowHeight = 44;
    _personTable.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        
        return 5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PHeadCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"cellph"];
        
        productCell.belongStore.text = [NSString stringWithFormat:@"所属店铺:%@",[FIUser shareUser].shopName];
        [productCell.photo sd_setImageWithURL:[NSURL URLWithString:[FIUser shareUser].imgUrl?:@""] placeholderImage:[UIImage imageNamed:@"GRXX-img-tx"]];
        productCell.name.text = [NSString stringWithFormat:@"姓名:%@",[FIUser shareUser].salesName];
        productCell.workNO.text = [NSString stringWithFormat:@"编号:%@",[FIUser shareUser].salesNo];
        int level = [[FIUser shareUser].serviceLvL intValue];
        if (level > 5) {
            level = 5;
        }
        for (int i = 1; i < level; i++) {
            UIImageView *imageV = [productCell.starView viewWithTag:(9+i)];
            imageV.image = [UIImage imageNamed:@"img-on"];
        }
        return productCell;
    }else{
        
        PContentCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"cellpc"];
        //    productCell.delegate = self;
        if (indexPath.row == 0) {
            productCell.hidden = NO;
            productCell.content.text = @"专属会员";
            productCell.message.text = [NSString stringWithFormat:@"%@个",[FIUser shareUser].exclusiveMemberNum];
            productCell.arrow.hidden = YES;
        }else if (indexPath.row == 1){
            productCell.content.text = @"我的提成";
            
        }else if (indexPath.row == 2){
            productCell.content.text = @"我的订单";
            
        }else if (indexPath.row == 3){
            productCell.content.text = @"意见反馈";
            
        }else {
            productCell.content.text = @"我的二维码";
        }
        
        return productCell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 2:
                [self.navigationController pushViewController:[DDOrderVCViewController new] animated:YES];

                break;
                case 3:
                [self.navigationController pushViewController:[DDAdviceVC new] animated:YES];
                break;
            case 4:
                [self.navigationController pushViewController:[DDMQRCode new] animated:YES];

                break;
                
            default:
                break;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}

@end
