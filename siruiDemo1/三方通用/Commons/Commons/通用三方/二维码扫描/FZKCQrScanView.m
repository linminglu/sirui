//
//  FZKCQrScanView.m
//  bussiceTest
//
//  Created by czl on 2017/4/11.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCQrScanView.h"
#import <AVFoundation/AVFoundation.h>

#define ScreenHigh [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScanLineH 3

@interface FZKCQrScanView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic)AVCaptureDevice *device;

@property (strong,nonatomic)AVCaptureDeviceInput *input;

@property (strong,nonatomic)AVCaptureMetadataOutput *output;

@property (strong,nonatomic)AVCaptureSession *session;

@property (strong,nonatomic)AVCaptureVideoPreviewLayer *preview;


@property (nonatomic,strong) NSTimer *timer;


@end

@implementation FZKCQrScanView
{

    CAGradientLayer *scanLayer;
    
    UIView *scanBox;

    NSInteger step;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    if (self) {
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            
        }else {
            [self preview];
            [self addScanView];
        }
//        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
//        self.layer.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2].CGColor;
    }
    return self;
}


#pragma mark - getter 
- (AVCaptureDevice *)device
{

    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

- (AVCaptureDeviceInput *)input
{

    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

-(AVCaptureMetadataOutput *)output{

    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc]init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
//        [_output setRectOfInterest:CGRectMake(124/ScreenHigh,((ScreenWidth-220)/2)/ScreenWidth,220/ScreenHigh,220/ScreenWidth)];
        _output.rectOfInterest = CGRectMake(0.35f, 0.2f, 0.7f, 0.8f);
        
    }
    return _output;
}

-(AVCaptureSession *)session{

    if (!_session) {
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if([_session canAddInput:self.input]){
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
             [_session addOutput:self.output];
            [_output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        }
       
    }
    return _session;
}

-(AVCaptureVideoPreviewLayer *)preview{

    if (!_preview) {
        _preview = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame = self.layer.bounds;

        [self.layer insertSublayer:_preview atIndex:0];
        
//        [self.session startRunning];
    }
    return _preview;
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
//        [self.session stopRunning];
        [self stop];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        if([self.delegate respondsToSelector:@selector(QrScanView:value:)]){
        
            [self.delegate QrScanView:self value:stringValue];
        }
        NSLog(@"扫描内容：%@",stringValue);
    }
}

- (void)pression
{

    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
       
    }else{
    }

    
}

- (void)addScanView
{

    UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHigh)];
    
    [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    [self addSubview:maskView];
    
    
    // 运用贝塞尔曲线配合CAShapeLayer
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, ScreenWidth, ScreenHigh)];
    
    // MARK: circlePath 画圆
//     [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(SelfW / 2, 200) radius:100 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    
    // MARK: roundRectanglePath 画矩形！
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(ScreenWidth *0.2f, ScreenHigh*0.35f, ScreenWidth - ScreenWidth*0.4f, ScreenHigh - ScreenHigh *0.7f) cornerRadius:0] bezierPathByReversingPath]];
//
//    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//
    shapeLayer.path = path.CGPath;
    shapeLayer.backgroundColor = [UIColor greenColor].CGColor;
    
    [maskView.layer setMask:shapeLayer];
    
//    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    // 设置扫描范围
    // 注意，这个属性各个方向的取值范围为0-1，表示占layer层的长度比例，x对应的是距离左上角的垂直距离，y对应的是距离左上角的水平距离，w对应的是底部距离左上角的垂直距离，h对应的是最右边距离左上角的水平距离
    
    
    // 设置扫描框
    scanBox = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth *0.2f, ScreenHigh*0.35f, ScreenWidth - ScreenWidth*0.4f, ScreenHigh - ScreenHigh *0.7f)];
//
    scanBox.layer.borderColor = [UIColor greenColor].CGColor;
    scanBox.layer.borderWidth = 1.0f;
    [self addSubview:scanBox];
    
    
    // 扫描线
    scanLayer = [[CAGradientLayer alloc]init];
    scanLayer.frame = CGRectMake(0, 0, scanBox.bounds.size.width, ScanLineH);
    [scanBox.layer addSublayer:scanLayer];
    // 设置渐变颜色方向
//    scanLayer.startPoint = CGPointMake(0, 0);
//    scanLayer.endPoint = CGPointMake(0, 1);
    // 设定颜色组
//    scanLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor brownColor].CGColor];
    scanLayer.colors = @[(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor clearColor].CGColor];
    
    
//    [timer fire];
//    [self.timer fire];
//    // 开始捕获
//    [_session startRunning];
    [self start];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    
    CGFloat leftX = ScreenWidth *0.2f;
    CGFloat leftY = ScreenHigh*0.35f;
    CGFloat rightX = leftX + ScreenWidth *0.6f;
    CGFloat rightY = leftY + ScreenHigh *0.3f;
//    四角线长度
    CGFloat wight = 10;
    
    //左上角水平线
    CGContextMoveToPoint(context, leftX, leftY);
    CGContextAddLineToPoint(context, leftX + wight, leftY);
    
    //左上角垂直线
    CGContextMoveToPoint(context, leftX, leftY);
    CGContextAddLineToPoint(context, leftX, leftY+wight);
    
    
    //左下角水平线
    CGContextMoveToPoint(context, leftX, rightY);
    CGContextAddLineToPoint(context, leftX + wight, rightY);
    
    //左下角垂直线
    CGContextMoveToPoint(context, leftX, rightY);
    CGContextAddLineToPoint(context, leftX, rightY - wight);
    
    
    //右上角水平线
    CGContextMoveToPoint(context, rightX, leftY);
    CGContextAddLineToPoint(context, rightX - wight, leftY);
    
    //右上角垂直线
    CGContextMoveToPoint(context, rightX, leftY);
    CGContextAddLineToPoint(context, rightX, leftY + wight);
    
    
    //右下角水平线
    CGContextMoveToPoint(context, rightX , rightY);
    CGContextAddLineToPoint(context, rightX - wight, rightY);
    
    //右下角垂直线
    CGContextMoveToPoint(context, rightX, rightY);
    CGContextAddLineToPoint(context, rightX, rightY - wight);
    
    CGContextStrokePath(context);
    

}

// 实现计时器方法moveScanLayer:

- (void)moveScanLayer:(NSTimer *)timer
{
    CGRect frame = scanLayer.frame;
//    NSLog(@"%f,%f",scanLayer.frame.origin.y+ScanLineH+5,ScreenHigh*0.65f);
    if (scanLayer.frame.origin.y<=0) {
        step = +5;
    }else if((scanLayer.frame.origin.y+ScanLineH+5)>=ScreenHigh*0.3f){
        step = -5;
    }
    frame.origin.y += step;
    [UIView animateWithDuration:0.1 animations:^{
        scanLayer.frame = frame;
    }];
    
}



/**
 开始
 */
- (void)start{
    if (_session && !_session.isRunning) {
        [_session startRunning];
        [self.timer fire];
    }

}


/**
 暂停
 */
- (void)stop{
    if (_session && _session.isRunning) {
        [_session stopRunning];
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - getter
- (NSTimer *)timer{

    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(moveScanLayer:) userInfo:nil repeats:YES];
    }
    return _timer;
}
@end
