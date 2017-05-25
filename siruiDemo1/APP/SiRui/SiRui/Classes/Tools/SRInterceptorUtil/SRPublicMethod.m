//
//  SRPublicMethod.m
//  SiRui
//
//  Created by czl on 2017/4/13.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRPublicMethod.h"
#import <AVFoundation/AVFoundation.h>
#import <Connector/FZKBVehicleStatusInfoModel.h>
#import <Connector/FZKBVehicleBasicInfoModel.h>
#import <Connector/FZKBKeychain.h>
//#import <Connector/FZKTCPClient.h>
//#import <Connector/FZKTBluetoothManager.h>
#import <Connector/FZKTCarStateManager.h>

@implementation SRPublicMethod


+ (BOOL)isCanUerCamer{

#if TARGET_IPHONE_SIMULATOR
    
    [SVProgressHUD showErrorWithStatus:@"模拟器不能使用摄像头"];
    return NO;
    
#else
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        [SVProgressHUD showErrorWithStatus:@"没有使用摄像头权限，请在系统设置中授权"];
        return NO;
    }else{
        return YES;
    }
#endif
}


+ (void)playMusicWithName:(NSString *)fileName{

    // 设置适当的类别UI的声音
    // 不沉默的其他音频
//    [[AVAudioSession sharedInstance] setCategory:@"AVAudioSessionCategoryAmbient" error:nil];
    
    NSString *audioFile=[[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSURL *fileUrl=[NSURL fileURLWithPath:audioFile];
    //1.获得系统声音ID
    SystemSoundID soundID=0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    //2.播放音频
//    AudioServicesPlaySystemSound(soundID);//播放音效
        AudioServicesPlayAlertSound(soundID);//播放音效并震动
}
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}

+ (NSString *)urlEnCode:(NSString *)url{
    
   CGFloat vision = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(vision<9.0){
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
    
       return  [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
}

/**
 
 退出登录清除数据
 
 */
+ (void)logoutClearData{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //重置当前选择车辆
        kSaveCurrentCarModleId(0);
        
        //清空状态值
        [[FZKBVehicleStatusInfoModel new]archive];
        
        //    车辆功能值
        [[FZKBVehicleBasicInfoModel new] archive];
        
        
        //删除账户密码
        [FZKBKeychain deletePassword];
        
        [[FZKTCarStateManager shareCarStateManager] applicationDidLoginout];
       
        
    });
   
    
    
}

@end

