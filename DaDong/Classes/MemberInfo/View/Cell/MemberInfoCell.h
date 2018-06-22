//
//  MemberInfoCell.h
//  DaDong
//
//  Created by lin on 2018/3/5.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *memberName;
@property (weak, nonatomic) IBOutlet UILabel *memberAccount;
@property (weak, nonatomic) IBOutlet UILabel *state;

@end
