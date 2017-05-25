

三方库集成API

1,FZKCRegisterCommonsAppkey 一键注册方式
根据配置自动设置appkey

/**
一键注册所有第三方库
*/

/**
注册第三方库

@param object 这里是iOS10以后推送的处理
@param launchOptions 点击通知将App从关闭状态启动时，将通知打开回执上报
*/
+ (void)registerCommonsAppkeyAppDelegateAndMessageReceive:(id<UNUserNotificationCenterDelegate>)object sendNotificationAck:(NSDictionary *)launchOptions getIpBlock:(void(^)(NSString * ip))back;



2，FZKCAnimationManager  动画管理器

/**
平移动画

@param x y轴默认为0
@param y Y轴默认为0
@param view 需要平移的视图
*/
+ (void) springPopTranslationWithX:(CGFloat)x y:(CGFloat)y view:(UIView *)view;

/**
旋转动画

@param angle 旋转角度 默认为0 书写如1*M_PI,M_PI/2等
@param view 需要旋转的视图
*/
+ (void) springPopRotatingWithAngle:(CGFloat)angle view:(UIView *)view;


/**
缩放动画

@param x y轴缩放倍数 默认为1
@param y Y轴缩放倍数  默认为1
@param view 需要缩放的视图
*/
+ (void) springPopZoomWithX:(CGFloat)x y:(CGFloat)y view:(UIView *)view;    



3，FZKCMapManager 地图管理器

/**
根据类型选择注册的地图

@param maptype 注册地图类型
*/
+ (void)registerMapType:(MapType)maptype;


/**
轨迹处理标注视图方法

@param annotation 标注
@return 标注视图
*/
+(BMKAnnotationView *)BaiduMapTraceViewForAnnotation:(FZKCSportPointAnnotation *)annotation;





/**
发起周边搜索

@param keyWord 关键字
@param radius 搜索半径
@param coordinate 坐标
@param poiSearch poi搜索类 包含高德和百度
*/
+(void)nearSearhKey:(NSString *)keyWord radius:(NSInteger)radius coordinate:(CLLocationCoordinate2D)coordinate  poiSearch:(id)poiSearch;




/**
添加运动轨迹并显示

@param locations
@param mapView
*/
+ (void)addBaiduTraceWithlocations:(NSArray<FZKSportNode *> *)locations toMapView:(BMKMapView *)mapView;


/**
开始轨迹运动
*/
+ (void)startBaiduTrace;

/**
暂停轨迹移动使用
*/
+(void)stopBaiduTrace;


/**
调起三方地图应用导航


@param endNode 终点
*/
+ (void)openThirdMapNode:(CLLocationCoordinate2D)endNode;


4  FZKCShareManager 分享管理器

/**
注册shareSDK appkey  ，其他的appkey 和AppSecret 在FZKAppkeyComon.h 文件中配置

@param appkey sharesdk
*/
+(void)registerShareSDKAppkey:(NSString *)appkey;


/**
*  设置分享参数
*
*  @param text     文本
*  @param images   图片集合,传入参数可以为单张图片信息，也可以为一个NSArray，数组元素可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage。如: @"http://www.mob.com/images/logo_black.png" 或 @[@"http://www.mob.com/images/logo_black.png"]
*  @param url      网页路径/应用路径
*  @param title    标题
*/
+(void)shareSetupShareParamsByText:(NSString *)text images:(id)images url:(NSURL *)url  title:(NSString *)title;


5 FZKCPayManager 支付管理器
/**
注册微信支付和支付宝 appkey

@param WXAppkey 微信appkey
@param aliAppkey 支付宝appkey 目前阿里appkey 不需要再本地写入，服务器自动返回 因此可以设置为nil
*/
+(void)registerWXAppkey:(NSString *)WXAppkey aliAppkey:(NSString *)aliAppkey;

/**
支付数据以及

@param params 支付参数
@param type 支付方式
*/
+(void)payWithParams:(id)params type:(PayType) type;


/**
调用支付结果

@param url 支付结果字符串
@param delegate 这里必填主appdelegate，不过是微信支付的时候才会发挥作用
@return 支付宝  直接返回支付结果，微信支付返回接收信息失败或者成功并设置主APPDelegate 为代理
*/
+(BOOL)getPayResult:(NSURL *)url appDelegate:(id<WXApiDelegate>)delegate;



/**
微信支付结果处理

@param resp 获取微信返回信息
*/
+(void)WXPay:(BaseResp *)resp;


6，FZKCAliPushManager 阿里云推送管理器
/**
注册阿里推送相关信息

@param appkey appkey description
@param appSecret appSecret description
@param callback callback description
@param object 设置代理为appdelegate
@param launchOptions 点击通知将App从关闭状态启动时，将通知打开回执上报
*/
+(void)registerAliPushAppKey:(NSString *)appkey appSecret:(NSString *)appSecret callback:(CallbackHandler)callback appDelegateAndMessageReceive:(id<UNUserNotificationCenterDelegate>)object sendNotificationAck:(NSDictionary *)launchOptions;

/**
苹果apns设备注册

@param res 设备注册回调
*/
+ (void)registerDevice:(NSData *)deviceToken withCallback:(CallbackHandler)res;



/*
*  App处于启动状态时，通知打开回调
*/
+ (void)applicationDidReceiveRemoteNotification:(NSDictionary*)userInfo;


/**
打开推送通知时进行的处理

@param response UNNotificationResponse
*/
+ (void)didReceiveNotificationResponse:(UNNotificationResponse *)response;


7，FZKCHTTPDNSManager 阿里云HTTPDNS管理器
/**
注册httpdns 服务器 设置预解析域名数组，设置解析域名地址

@param count 账户
@param resolveHosts 预解析域名数组 //@[ @"www.chinapke.com", @"www.taobao.com", @"gw.alicdn.com", @"www.tmall.com", @"dou.bz"]
@param back 获取解析后ip的处理
*/
+(void)registerAliHTTPDNSCount:(int)count preResolveHosts:(NSArray *)resolveHosts getIp:(void(^)(NSString * ip)) back;
