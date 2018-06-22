//
//  OrderCell.h
//  DaDong
//
//  Created by lin on 2018/3/1.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderInfo;
@class OrderCell;
@protocol StateOrderClickDelegate<NSObject>
@optional

- (void)clickSatateAction:(OrderCell *)cell;

@end
@interface OrderCell : UITableViewCell
@property (assign, nonatomic) id<StateOrderClickDelegate> delegate;
@property (assign, nonatomic) NSOrderType type;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *commission;
@property (weak, nonatomic) IBOutlet UILabel *state;
- (IBAction)stateBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumber;
- (void)fillCellWith:(OrderInfo *)orInfo;
@property (weak, nonatomic) IBOutlet UIImageView *righA;

@end
