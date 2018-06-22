//
//  DDAdviceVC.m
//  DaDong
//
//  Created by lin on 2018/3/5.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDAdviceVC.h"
#import "DDAdviceSucessVC.h"
#import "DDAdviceRequest.h"
#import <MBProgressHUD.h>
#import "WToast.h"
@interface DDAdviceVC ()<UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *adviceType;

@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)confirmAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *placeHoder;
@property (strong, nonatomic) IBOutlet UIView *adviceTypeView;
- (IBAction)typeAction:(id)sender;

- (IBAction)cancleA:(id)sender;
- (IBAction)finishA:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic)  UIView *shadowView;
@property (strong, nonatomic) NSArray *arr;
@property (copy, nonatomic) NSString *selectStr;
@end

@implementation DDAdviceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0.7;
    _arr = [[NSArray alloc] initWithObjects:@"促销活动",@"售后",@"商品调拨",@"查库存",@"代课下单", @"会员代注册",@"会员明细",@"提成账户",@"目标与达成",@"业绩统计",@"会员分析",@"人资管理",@"其他",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -text delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    if (![text isEqualToString:@""]){
        
        _placeHoder.hidden = YES;
//        _button.enabled = YES;
//        _button.backgroundColor = BlueTintColor;
        
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        
        _placeHoder.hidden = NO;
//        _button.enabled = NO;
//        _button.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    
    return YES;
    
}

//- (void)textViewDidChange:(UITextView *)textView
//{
//    NSInteger left = TextMaxLength - textView.text.length;
//    if (textView.markedTextRange == nil && TextMaxLength > 0 && textView.text.length > TextMaxLength) {
//        textView.text = [textView.text substringToIndex:TextMaxLength];
//        _textNumberL.text=@"0";
//        return;
//    }
//    if (left<0) {
//        return;
//    }
//    _textNumberL.text=[NSString stringWithFormat:@"%ld",(long)(TextMaxLength-textView.text.length)];
//}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"yes");
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeHoder.hidden = YES;
}
- (void)confirmAction:(id)sender{
    [self uploadAdvice];
}
- (void)uploadAdvice{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    DDAdviceRequest *request = [DDAdviceRequest Request];
    request.shopNo = @"ws002";
    request.salesNo = @"jack2018";
    request.comment = _textView.text;
    [request startCallBack:^(BOOL isSuccess, NetworkModel *result) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (isSuccess) {
            [WToast showWithTextCenter:@"sucess"];
            [self.navigationController  pushViewController:[DDAdviceSucessVC new] animated:YES];

            //                [MBProgressHUD showSuccess:@"短信验证码发送成功" toView:self.view];
        }else{
            //                [MBProgressHUD showError:result.message toView:self.view];
            [WToast showWithTextCenter:result.message];
        }
    }];
}
- (IBAction)typeAction:(id)sender {
    [self.view endEditing:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_adviceTypeView];
    _adviceTypeView.frame= CGRectMake(0, SCREEN_HEIGHT - 220, SCREEN_WIDTH, 212);
    [[UIApplication sharedApplication].keyWindow addSubview:_adviceTypeView];
}

- (IBAction)cancleA:(id)sender {
    [_shadowView removeFromSuperview];
    [_adviceTypeView removeFromSuperview];
    _selectStr = @"";
}

- (IBAction)finishA:(id)sender {
    [_shadowView removeFromSuperview];
    [_adviceTypeView removeFromSuperview];
    _adviceType.text = _selectStr;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _arr.count;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _arr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectStr = _arr[row];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *lbl = (UILabel *)view;
    
    if (lbl == nil) {
        
        lbl = [[UILabel alloc]init];
        
        //在这里设置字体相关属性
        
        lbl.font = [UIFont systemFontOfSize:14];
        
        lbl.textColor = RGBCOLORV(0x1C1C20);
        
        [lbl setTextAlignment:NSTextAlignmentCenter];
        
        [lbl setBackgroundColor:[UIColor clearColor]];
        
    }
    
    //重新加载lbl的文字内容
    
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return lbl;
    
}
@end
