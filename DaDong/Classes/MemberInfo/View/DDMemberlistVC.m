//
//  MemberlistVC.m
//  DaDong
//
//  Created by lin on 2018/3/5.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDMemberlistVC.h"
#import "MemberInfoCell.h"
#import "MemberInfoCCell.h"
#import "DDMemRequest.h"
#import "DDMemberInfo.h"
@interface DDMemberlistVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *memberTable;
@property (strong, nonatomic) IBOutlet UIView *naviView;
@property (weak, nonatomic) IBOutlet UITextField *naviTf;
- (IBAction)searchAciton:(id)sender;
- (IBAction)backAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UIView *titleView2;
@property (strong, nonatomic) NSMutableArray *arrMessage;
@end

@implementation DDMemberlistVC
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    
    self.naviView.frame = CGRectMake(0, 20, SCREEN_WIDTH, 44);
    if (kDevice_Is_iPhoneX) {
        self.naviView.frame = CGRectMake(0, 44, SCREEN_WIDTH, 44);
    }
    [self.view addSubview:self.naviView];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [_memberTable registerNib:[UINib nibWithNibName:@"MemberInfoCell" bundle:nil] forCellReuseIdentifier:@"cellM"];
      [_memberTable registerNib:[UINib nibWithNibName:@"MemberInfoCCell" bundle:nil] forCellReuseIdentifier:@"cellMC"];
    _memberTable.estimatedRowHeight = 44;
    _memberTable.rowHeight = UITableViewAutomaticDimension;
    self.titleView2.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
    [self.view addSubview:self.titleView2];
//    [self memberDataLoad];
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
    
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberInfoCCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"cellMC"];
    //    productCell.delegate = self;
    DDMemberInfo *infom = _arrMessage[indexPath.row];
    productCell.memberName.text = infom.memberName;
    productCell.account.text = infom.memberNo;
    return productCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
}
- (IBAction)searchAciton:(id)sender {
    
    
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)memberDataLoad {
    _arrMessage = [[NSMutableArray alloc] init];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DDMemRequest *request = [DDMemRequest Request];
    request.salesNo = @"dg002";
    request.shopNo = @"wz001";
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (isSuccess) {
            if ([result.data isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dic in result.data) {
                    DDMemberInfo *infoD = [DDMemberInfo objectWithKeyValues:dic];
                    [_arrMessage addObject:infoD];
                }
            }
            [_memberTable reloadData];
        }else{
            [WToast showWithTextCenter:result.message];        }
    }];
}
@end
