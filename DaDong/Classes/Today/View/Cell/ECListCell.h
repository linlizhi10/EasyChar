//
//  ActivityCell.h
//  DaDong
//
//  Created by lin on 2018/3/12.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *amout;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIImageView *line;

@end
