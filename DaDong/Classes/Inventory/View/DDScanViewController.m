//
//  DDScanViewController.m
//  DaDong
//
//  Created by lin on 2018/2/27.
//  Copyright © 2018年 WintrueTeam. All rights reserved.
//

#import "DDScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Frame.h"
#define DefautlBackgroundColor RGBColor(236, 237, 238)

@interface DDScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
@property (assign, nonatomic)BOOL scannerAvailable;

@property (strong, nonatomic)UIImageView *container;
@property (strong, nonatomic)UIView *scanLIneView;
@property (strong, nonatomic)AVCaptureSession *session;
@property (strong, nonatomic)AVCaptureDeviceInput *deviceInput;
@property (strong, nonatomic)AVCaptureMetadataOutput *output;
@property (strong, nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic)CALayer  *drawer;
@end

@implementation DDScanViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self startAnimation];
    
    [self startScan];
    
    self.container.frame = CGRectMake((self.view.width - self.container.width) * 0.5, (self.view.height - self.container.width)*0.5 , self.container.width, self.container.height);
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [self setNavigationBarTitleTextAttributesWith:[UIColor whiteColor] textFontSize:16];
    [self.navigationController.navigationBar setBarTintColor:RGBColor(50, 48, 47)];
//    [self setWhiteStyleBackItemWithDefaultAction];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = DefautlBackgroundColor;
    [self.view addSubview:self.container];
    [self.container addSubview:self.scanLIneView];
    [self setUpSesstion];
    self.navigationItem.title = @"扫一扫";
    
    if (!_scannerAvailable) {
//        [self.alertView showEorXHStatusWithBackgroundHUD:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - scan
- (void)startAnimation{
    
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    [animationMove setFromValue:[NSNumber numberWithFloat:0]];
    [animationMove setToValue:[NSNumber numberWithFloat:self.container.height - self.scanLIneView.height]];
    animationMove.duration = 1.5;
    animationMove.repeatCount  = OPEN_MAX;
    animationMove.fillMode = kCAFillModeForwards;
    animationMove.removedOnCompletion = NO;
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.scanLIneView.layer addAnimation:animationMove forKey:@"scanneLineAnimation"];
}


- (void)setUpSesstion{
    
    if (![self.session canAddInput:self.deviceInput]) {
        self.drawer.backgroundColor = DefautlBackgroundColor.CGColor;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"无摄像头访问权限!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }else{
        [self.session addInput:self.deviceInput];
    }
    
    
    if (![self.session canAddOutput:self.output]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"无摄像头访问权限!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }else{
        WeakSelf ws = self;
        [self.output setMetadataObjectsDelegate:ws queue:dispatch_get_main_queue()];
        [self.session addOutput:self.output];
    }
    
    
    //[self.output availableMetadataObjectTypes]
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    [self.previewLayer addSublayer:self.drawer];
}

- (void)startScan{
    
    [self.session startRunning];
    
    //intertsRect must be set after previewLayer being added
    [self updateInterestRectWithSessionRestart:NO];
}

- (void)updateInterestRectWithSessionRestart:(BOOL)restart{
    
    CGFloat rectX = (self.view.width - self.container.frame.size.width)*0.5;
    CGFloat rectY = (self.view.height - self.container.height)*0.5;
    CGFloat rectW = self.container.frame.size.width;
    CGFloat rectH = self.container.height;
    
    CGRect rect = CGRectMake(rectX, rectY, rectW, rectH);
    
    CGRect intertRect = [self.previewLayer metadataOutputRectOfInterestForRect:rect];
    //CGRect layerRect = [self.previewLayer rectForMetadataOutputRectOfInterest:intertRect];
    
    
    [self.output setRectOfInterest:intertRect];
    
    if (restart) {
        [self startScan];
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (_scannerAvailable) {
        if (metadataObjects.count > 0) {
            [self.session stopRunning];
            NSString *result =  [metadataObjects.lastObject stringValue];
            //处理扫描结果
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self dealScannerResultWith:result];
            });
        }
    }
}

- (UIImageView *)container{
    if (!_container) {
        CGFloat WH = 257;
        _container = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - WH) * 0.5, (self.view.height - WH)*0.5 , WH, WH)];
        _container.alpha = 1;
        _container.image = [UIImage imageNamed:@"sys_k"];
    }
    return _container;
}

- (UIView *)scanLIneView{
    if (!_scanLIneView) {
        _scanLIneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.container.width, 2)];
        _scanLIneView.backgroundColor = RGBColor(16, 131, 231);
    }
    return _scanLIneView;
}

- (CALayer *)drawer{
    
    if (!_drawer) {
        _drawer = [[CALayer alloc] init];
        _drawer.frame = [UIScreen mainScreen].bounds;
    }
    return _drawer;
}

- (AVCaptureVideoPreviewLayer *)previewLayer{
    
    if (!_previewLayer) {
        
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _previewLayer.frame = self.view.bounds;
    }
    return _previewLayer;
}

- (AVCaptureMetadataOutput *)output{
    
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
    }
    return _output;
}

- (AVCaptureSession *)session{
    
    if (!_session) {
        
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
    }
    return _session;
}

- (AVCaptureDeviceInput *)deviceInput{
    
    if (!_deviceInput) {
        
        NSError *error;
        _deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:&error];
        if (error) {
            return nil;
        }
    }
    return _deviceInput;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
         [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
