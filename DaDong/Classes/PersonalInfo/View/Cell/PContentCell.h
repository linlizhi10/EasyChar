//
//  PContentCell.h
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *message;

@end
