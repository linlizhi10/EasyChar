//
//  PHeadCell.h
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *workNO;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *belongStore;
@property (weak, nonatomic) IBOutlet UIView *starView;

@end
