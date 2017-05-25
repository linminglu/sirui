//
//  SRTCPClient.m
//  SiRuiV4.0
//
//  Created by zhangjunbo on 15/6/16.
//  Copyright (c) 2015年 SiRui. All rights reserved.
//


#import "FZKBKeychain.h"
#import "FZKTCPClient.h"
#import "FZKTCPRequest.h"
#import "FZKTCPRequestHead.h"
#import "FZKTCPResponse.h"
#import "FZKTCPResponseBody.h"
#import "FZKTCPResponseHead.h"
#import "FZKTCPRspInvokeResult.h"
#import "FZKTLV.h"
#import "FZKCUserDefaults.h"
#import <AFNetworking/AFNetworking.h>
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
//#import <KVOController/FBKVOController.h>
#import <MJExtension/MJExtension.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FZKTCPConfig.h"
#import "FZKEnum.h"
#import <MJExtension/MJExtension.h>
#import "FZKTCPParseResponse.h"
#import <YYKit.h>







@interface FZKTCPClient () <GCDAsyncSocketDelegate>
{
    
}

@property (nonatomic, strong) GCDAsyncSocket *asyncSocket;

//接收到的完整数据包
@property (nonatomic, strong) NSMutableString *receivedString;

//心跳定时器
@property (nonatomic,strong) YYTimer *timer;

@end

@implementation FZKTCPClient
{
    
}


+(FZKTCPClient *)shareTCPClient{
    static FZKTCPClient *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token,^{
        if(manager == nil){
            manager = [[FZKTCPClient alloc]init];
        }
    } );
    return manager;
}






+ (void) startNetWorkReachabilityMonitoring {
    
    [[AFHTTPSessionManager manager].reachabilityManager startMonitoring];
}


- (void)dealloc {
    
    
    
    self.completeBlockDic = nil;
    
    
}

#pragma mark - getter
- (YYTimer *)timer{
    
    if (!_timer) {
        
        _timer = [YYTimer timerWithTimeInterval:30 target:self selector:@selector(startKeepAliveTimelyWithHeartbeat) repeats:YES];
        //        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}


- (NSMutableString *)receivedString{
    
    if (!_receivedString) {
        _receivedString = [NSMutableString new];
    }
    return _receivedString;
}

- (instancetype)init
{
    self = [super init];
    
    
    
    if (!self) return nil;
    
    _isRedirected = NO;
    _latestSynchronousResponseSerialNumber = -1;
    
    //    _receivedData = [NSMutableData data];
    _completeBlockDic = [NSMutableDictionary dictionary];
    
    
    
    _asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                              delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [_asyncSocket setAutoDisconnectOnClosedReadStream:NO];
    
    _host = [FZKTCPConfig TcpHost];
    _port = [FZKTCPConfig TcpPort];
    
    
    
    return self;
}

- (BOOL)needConnect {
    //    NSLog(@"%zd %zd %zd", _asyncSocket.isConnected, [SRUserDefaults isLogin], isTCPLogin);
    return !_asyncSocket.isConnected
    && [FZKCUserDefaults isLogin]
    && !_isTCPLogin;
}

- (void)tcpLogin
{
    if (!_asyncSocket.isConnected || ![FZKCUserDefaults isLogin] || _isTCPLogin) {
        return ;
    }
    
    FZKTCPRequest *loginRequest = [FZKTCPRequest LoginRequestWithUserName:[FZKBKeychain UserName]
                                                              andPassword:[FZKBKeychain Password]];
    
    @weakify(self)
    [self sendTCPRequest:loginRequest withCompleteBlock:^(NSError *error, FZKTCPResponseHead *responseHead) {
        @strongify(self)
        
        if (error) {
            NSLog(@"Login error: %@ %@============================================= 登陆错误", error, responseHead);
            [self executeOnMain:^{
                [self connect];
            } afterDelay:kTcpResponseTimeOutSeconds_sr];
        } else {
            if (self.isTCPLogin) {
                _isTCPLogin = YES;
                NSLog(@"current:%@,main:%@",[NSThread currentThread],[NSThread mainThread]);
                
                
                if (!self.timer.valid) {
                    [self.timer fire];
                }
                
                
            }
            
        }
    }];
}



#pragma mark - 连接管理

- (void)connect{
    
    //超过3次还未连接上需要重新重定向
    ++_connectRetryTimes;
    NSLog(@"TCP 连接次数：%zd", _connectRetryTimes);
    _isRedirected = _connectRetryTimes>kTcpMaxConnectRetryTimes_sr?NO:_isRedirected;
    
    if (!_isRedirected) {
        self.host = [FZKTCPConfig TcpHost];
        self.port = [FZKTCPConfig TcpPort];
        NSLog(@"开始寻址");
    } else {
        NSLog(@"开始重定向");
    }
    
    if (![FZKCUserDefaults isLogin]) {
        NSLog(@"未登录");
        
        return;
    }
    
    if (_host.length <= 0 && _port<=0) {
        NSLog(@"地址错误");
//        NSError *error = [[NSError alloc] initWithDomain:@"地址错误" code:0 userInfo:nil];
        return;
    }
    //    if (![AFHTTPSessionManager manager].reachabilityManager.reachable) {
    //        NSLog(@"无网络");
    //
    //        return;
    //    }
    
    if (_asyncSocket.isConnected) {
        [_asyncSocket disconnect];
        _isTCPLogin = NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_asyncSocket connectToHost:_host onPort:_port withTimeout:kTcpConnectTimeOutSeconds_sr error:nil];
    });
    
    
    
    
    
    
    
}

- (void)disconnect {
    [_asyncSocket disconnect];
    //暂停定时器
    [self.timer invalidate];
    _isKeepAliveTimeOut = NO;
    self.receivedString = nil;
    _isTCPLogin = NO;
    _isRedirected = NO;
}

- (BOOL)connectState{
    
    return _isTCPLogin&&_asyncSocket.isConnected;
}

#pragma mark - 数据发送

- (void)sendTCPRequest:(FZKTCPRequest *)request withCompleteBlock:(CompleteBlock)completeBlock
{
    @weakify(self)
    
    if (request.head.functionID != TCPFuncID_Addressing && [self.host isEqualToString:[FZKTCPConfig TcpHost]]) {
        
        if (!_asyncSocket.isConnected) {
            [self connect];
        }
        
        return;
    }
    
    [_asyncSocket writeData:[request dataValue] withTimeout:-1 tag:request.head.serialNumber];
    
    if (completeBlock) {
        [_completeBlockDic setObject:completeBlock forKey:@(request.head.serialNumber)];
        [self executeOnMain:^{
            @strongify(self)
            CompleteBlock block = [self.completeBlockDic objectForKey:@(request.head.serialNumber)];
            if (block) {
                [self.completeBlockDic removeObjectForKey:@(request.head.serialNumber)];
                NSLog(@"serialNumber:%@ TCP响应超时", @(request.head.serialNumber));
                NSError *error = [NSError errorWithDomain:@"网络连接错误" code:NSURLErrorTimedOut userInfo:nil];
                block(error, nil);
                block = nil;
            }
        } afterDelay:(request.head.functionID==TCPFuncID_Addressing||request.head.functionID==TCPFuncID_Login)?kTcpConnectTimeOutSeconds_sr:kTcpResponseTimeOutSeconds_sr];
    }
}

- (void)startKeepAliveTimelyWithHeartbeat{
    
    if (!_isKeepAliveTimeOut) {
        _isKeepAliveTimeOut = YES;
        NSLog(@"发送心跳请求");
        [self.asyncSocket writeData:[GCDAsyncSocket ZeroData] withTimeout:kTcpResponseTimeOutSeconds_sr tag:0];
    }
    else{
        
        [self disconnect];
        [self connect];
        
        
    }
    
}

#pragma mark - 解包

- (void)parseReceivedData:(NSData *)data
{
    //并发执行
    @weakify(self)
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        @strongify(self)
        
        FZKTCPResponse *packet;
        
        if ((packet = [self getPacketFromReceivedData:data])) {
            //                解析数据
            [FZKTCPParseResponse parseResponseWithResponse:packet];
        }
        
        
    });
    
    
}

- (FZKTCPResponse *)getPacketFromReceivedData:(NSData *)data {
    
    
    if (!data || data.length<8) return nil;
    
    NSInteger length = [[[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 4)]
                                              encoding:NSUTF8StringEncoding]
                        integerValue];
    
    if (data.length < length + 8) return nil;
    
    
//    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    if (data.length > 8){
        
        data = [data subdataWithRange:NSMakeRange(8, data.length-8)];
        
        NSError *error;
        
        NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
        
        //            NSLog(@"截获字符串***************》：\n%@\n***************",jsonObject);
        if (error) {
            if (!_isTCPLogin && _isRedirected) {
                [self tcpLogin];
            }
            return nil;
        }
        
        return [FZKTCPResponse mj_objectWithKeyValues:jsonObject];
        
        
        
        
    }
    
    return nil;
    
    
    
}









- (void)executeOnMain:(dispatch_block_t)block afterDelay:(int64_t)delta {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta),
                   dispatch_get_main_queue(),
                   block);
}





#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"socket:%p didConnectToHost:%@ port:%hu", sock, host, port);
    
    
    _latestSynchronousResponseSerialNumber = -1;
    _connectRetryTimes = 0;
    
    if (_isRedirected) {
        //登陆
        [self tcpLogin];
    } else {
        //寻址
        
        if (![FZKBKeychain UserName]) {
            return;
        }
        
        FZKTCPRequest *request = [FZKTCPRequest AddressingRequestWithUserName:[FZKBKeychain UserName]];
        @weakify(self)
        [self sendTCPRequest:request withCompleteBlock:^(NSError *error, FZKTCPResponseHead *responseHead) {
            @strongify(self)
            _isTCPLogin = NO;
            if (error) {
                NSLog(@"%@ %@", error, responseHead);
                //寻址失败，重新连接
                @weakify(self)
                [self executeOnMain:^{
                    @strongify(self)
                    _isRedirected = NO;
                    [self connect];
                } afterDelay:kTcpResponseTimeOutSeconds_sr];
                
            } else {
                [sock disconnect];
                _isRedirected = YES;
                //寻址成功，重定向到新地址
                [self connect];
            }
        }];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"socketDidDisconnect:%p withError: %@", sock, err);
    
    _latestSynchronousResponseSerialNumber = -1;
    _isTCPLogin = NO;
    self.receivedString = nil;
    
    _isKeepAliveTimeOut = NO;
    //正常断开
    if (!err) return;
    
}

- (void)socketDidSecure:(GCDAsyncSocket *)sock {
    [_asyncSocket readDataWithTimeout:-1 tag:0];
}

- (NSTimeInterval)socket:(GCDAsyncSocket *)sock shouldTimeoutWriteWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length {
    return elapsed;
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [_asyncSocket readDataWithTimeout:-1 tag:tag];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    [_asyncSocket readDataWithTimeout:-1 tag:0];
    
    //必要的转换防止出现异常
    NSString *parseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *newData = [parseStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"didReadData:%@", parseStr);
    
    if ([data isEqualToData:[GCDAsyncSocket ZeroData]]) {
        _isKeepAliveTimeOut = NO;
        NSLog(@"收到心跳响应");
        return;
    }
    
    NSInteger length = [[[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 4)]
                                              encoding:NSUTF8StringEncoding]
                        integerValue];
    
    NSLog(@"-------数据包长度:--%ld------\n接收数据长度---%ld--------\n",length,data.length);
    
    
    
    if (newData.length-8==length && [parseStr containsString:@"{\"body\":"] &&[parseStr containsString:@"}}"]) {
        //        清空数据
        self.receivedString = nil;
        //数据完整的解析
        [self parseReceivedData:newData];
        
    }else{
        
        [self.receivedString appendString:parseStr];
        
        //解析后多余字符串
        NSString *newStr = [self parseArray:[self.receivedString componentsSeparatedByString:@"}}"]];
        
        self.receivedString = nil;
        
        if(newStr){
            
            [self.receivedString appendString:newStr];
            
        }
        
        
    }
    
    
    
    
}


/**
 解析数组
 
 @param array 间隔数组
 @return 字符串
 */
- (NSString *)parseArray:(NSArray *)array{
    
    //    NSMutableArray *parse = [NSMutableArray new];
    
    //去重
    NSMutableDictionary *parseDic = [NSMutableDictionary new];
    
    for (NSString *str in array) {
        
        if ([str containsString:@"{\"body\":"]) {
            
            [parseDic setObject:[NSString stringWithFormat:@"%@}}",str] forKey:[str substringToIndex:8]];
            
        }
        
    }
    
    for ( NSString *str in parseDic.allValues){
        //解析
        [self parseReceivedData:[str dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    NSString *lastStr = [array lastObject];
    if (lastStr.length>0) {
        return lastStr;
    }
    
    return nil;
    
}



@end
