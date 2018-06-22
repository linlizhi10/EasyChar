//
//  DDActivityVC.m
//  DaDong
//
//  Created by lin on 2018/3/12.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "ECTodayVC.h"
#import "ECListCell.h"
#import "DDActivityDetailVC.h"
#import "DDActivityRequest.h"
@interface ECTodayVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *activityTable;
@property (strong, nonatomic) NSMutableArray *arrActive;

@end

@implementation ECTodayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日收支";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_activityTable registerNib:[UINib nibWithNibName:@"ECListCell" bundle:nil] forCellReuseIdentifier:@"cellECL"];
    _activityTable.estimatedRowHeight = 100;
//    [self activityDataLoad];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ECListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellECL"];
    
   
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)activityDataLoad{
    _arrActive = [[NSMutableArray alloc] init];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DDActivityRequest *request = [DDActivityRequest Request];
    request.shopID = @"1111";
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        if (isSuccess) {
            [WToast showWithTextCenter:@"sucess"];
            if ([result.data isKindOfClass:[NSArray class]]) {
                for ( NSDictionary *dic in result.data) {
                  
                }
            }
            [_activityTable reloadData];
            
        }else{
            //                [MBProgressHUD showError:result.message toView:self.view];
            [WToast showWithTextCenter:result.message];
        }
    }];
}
@end
