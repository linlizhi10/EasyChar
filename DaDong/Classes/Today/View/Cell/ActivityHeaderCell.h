//
//  ActivityHeaderCell.h
//  DaDong
//
//  Created by lin on 2018/3/12.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *activityContent;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *district;
@property (weak, nonatomic) IBOutlet UILabel *limitTimeA;

@end
