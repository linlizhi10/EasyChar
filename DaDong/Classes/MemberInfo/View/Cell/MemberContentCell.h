//
//  MemberContentCell.h
//  DaDong
//
//  Created by lin on 2018/3/6.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleContent;
@property (weak, nonatomic) IBOutlet UILabel *subContent;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrow;

@end
