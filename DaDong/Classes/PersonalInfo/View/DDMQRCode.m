//
//  DDMQRCode.m
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDMQRCode.h"
#import "FIUser.h"
@interface DDMQRCode ()
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIImageView *QRImage;

@end

@implementation DDMQRCode

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    _name.text = [FIUser shareUser].salesName;
    _adress.text = [FIUser shareUser].shopAddress;
    [_photo sd_setImageWithURL:[NSURL URLWithString:[FIUser shareUser].imgUrl?:@""] placeholderImage:[UIImage imageNamed:@"GRXX-img-tx"]];
    [_QRImage sd_setImageWithURL:[NSURL URLWithString:[FIUser shareUser].qrCode?:@""] placeholderImage:[UIImage imageNamed:@"DDZF-img-QRcode"]];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
