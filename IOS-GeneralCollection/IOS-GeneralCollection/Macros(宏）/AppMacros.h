//
//  AppMacros.h
//  MyAssistant
//
//  Created by apple on 18/9/6.
//  Copyright © 2018年 LuXing. All rights reserved.
//

#ifndef AppMacros_h
#define AppMacros_h



/*********应用*********/

//应用委托
#define kAppDelegate   ((AppDelegate *)[UIApplication sharedApplication].delegate)
//应用名称和版本
#define kAPPName       [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define kAPPVersion    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//跟控制器
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController



/**************系统*************/


//系统版本和语言
#define kSystemVersion    ([[UIDevice currentDevice] systemVersion])
#define kCurrentLanguage  ([[NSLocale preferredLanguages] objectAtIndex:0])

//系统版本工具
#define systemVersionEqualTo(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define systemVersionGreaterThan(v)          ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define systemVersionGreaterThanOrEqualTo(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define systemVersionlessThan(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define systemVersionlessThanOrEqualTo(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//判断 iOS 或更高的系统版本
#define IOS_VERSION_6_OR_LATER  (([[[UIDevice currentDevice] systemVersion] floatValue]>=6.0)? (YES):(NO))
#define IOS_VERSION_7_OR_LATER  (([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)? (YES):(NO))
#define IOS_VERSION_8_OR_LATER  (([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)? (YES):(NO))
#define IOS_VERSION_9_OR_LATER  (([[[UIDevice currentDevice] systemVersion] floatValue]>=9.0)? (YES):(NO))
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0)? (YES):(NO))




/*************设备*************/

//设备相关
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPOD    ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//检测是否是竖屏状态
#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)

//屏幕
#define kScale        [[UIScreen mainScreen] scale]
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kScreenMaxLength (MAX(kScreenWidth, kScreenHeight))
#define kScreenMinLength (MIN(kScreenWidth, kScreenHeight))


//尺寸

#define IS_IPHONE_4_OR_LESS  (IS_IPHONE && kScreenMaxLength < 568.0)
//5、SE相同尺寸
#define IS_IPHONE_5SE        (IS_IPHONE && kScreenMaxLength == 568.0)
//6、7、8相同尺寸
#define IS_IPHONE_8          (IS_IPHONE && kScreenMaxLength == 667.0)
//6P、7P、8P相同尺寸
#define IS_IPHONE_8P         (IS_IPHONE && kScreenMaxLength == 736.0)
#define IS_IPHONE_X          (IS_IPHONE && kScreenMaxLength == 812.0)



// iPhone X 导航栏高度
#define kIphoneXNavHeight          44.0f
// iPhone X 状态栏高度
#define kIphoneXStatusBarHeight    44.0f
// iPhone X 工具栏高度
#define kIphoneXToolBarHeight      83.0f


// 其他 iPhone 导航栏高度
#define kIphoneNavHeight           44.0f
// 其他 iPhone 状态栏高度
#define kIphoneStatusBarHeight     20.0f
// 其他 iPhone 工具栏高度
#define kIphoneToolBarHeight       49.0f


//导航栏高度
#define kNavigationBarHeight       44.0f
//状态栏高度
#define kStatusBarHeight           (IS_IPHONE_X ? kIphoneXStatusBarHeight : kIphoneStatusBarHeight)
//工具栏高度
#define kToolBarHeight             (IS_IPHONE_X ? kIphoneXToolBarHeight : kIphoneToolBarHeight)


//
//// 顶部安全距离
//#define kSafeAreaTopHeight      (IS_IPHONE_X ? 88.f : 64.f)
//// 底部安全距离
//#define kSafeAreaBottomHeight   (IS_IPHONE_X ? 34.f : 0.f)
//// Tabbar高度
//#define kTabbarHeight           49.f
//// 去除上下导航栏剩余中间视图高度
//#define ContentHeight           (kScreenHeight - kSafeAreaTopHeight - kSafeAreaBottomHeight - kTabbarHeight)
/////

//内容视图高度
#define kContentHeight  (kScreenHeight - kNavigationBarHeight - kStatusBarHeight)
//工具栏高度
#define kTabbarHeight   self.tabBarController.tabBar.frame.size.height

//根据ip6、7、8的屏幕来拉伸
#define realWidthValue(width)   ((width)*(KScreenWidth/375.0f))
#define realHeightValue(height) ((height)*(KScreenWidth/667.0f))






/************其他**************/



//度弧度转换
#define degreesToRadian(x)      (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0) / (M_PI)


//Block self
#define kWeakSelf    __weak     typeof(self)  weakSelf = self;
#define kStrongSelf  __strong   typeof(weakSelf) strongSelf = weakSelf;
// 强弱引用
#define WS(weakSelf)  __weak    __typeof(&*self)weakSelf = self;

//获取系统时间戳
#define kCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]
//GCD
#define kGCDMain(block)        dispatch_async(dispatch_get_main_queue(),(block))
#define kGCDBackground(block)  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), (block))

//加锁、解锁
#define Lock()   dispatch_semaphore_wait(self->_lock, DISPATCH_TIME_FOREVER)
#define Unlock() dispatch_semaphore_signal(self->_lock)





/**********view********/


//字体
#define systemFont(X)     [UIFont systemFontOfSize:X]
#define boldSystemFont(X) [UIFont boldSystemFontOfSize:X]


//UIImage
#define imageName(x)            [UIImage imageNamed:x]
#define imageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@@%dx",_pointer,(int)[UIScreen mainScreen].nativeScale]ofType:@"png"])]



//视图高度
#define kViewHeight   self.view.bounds.size.height
#define kViewWidth    self.view.bounds.size.width

//view边框
#define viewBorderRadius(view,radius,width,color)\
[view.layer setCornerRadius:radius];\
[view.layer setMasksToBounds:YES];\
[view.layer setBorderWidth:width];\
[view.layer setBorderColor:[color CGColor]];

//view圆角
#define viewRadius(view,radius)\
[view.layer setCornerRadius:(radius)];\
[view.layer setMasksToBounds:YES];

//以tag读取View
#define viewByTag(parentView, tag, Class)  (Class *)[parentView viewWithTag:tag]
//读取Xib文件的类
#define viewByNib(Class, owner, index) [[[NSBundle mainBundle] loadNibNamed:Class owner:owner options:nil] objectAtIndex:index]




/****************颜色************/


#define kRGBColor(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kRGBAColor(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kHEXColor(c)         [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0];
//16进制转色值
#define kRGB16Color(rgbValue)   [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//16进制转色值带透明度
#define kRGBA16Color(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]
//设置随机颜色(调试时候很有用)
#define randomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]






/**********property属性快速声明******************/
#define propertyInt(s)                @property(nonatomic,assign)int s
#define propertyBool(s)               @property(nonatomic,assign)BOOL s
#define propertyFloat(s)              @property(nonatomic,assign)float s
#define propertyLongLong(s)           @property(nonatomic,assign)long long s
#define propertyNSInteger(s)          @property(nonatomic,assign)NSInteger s
#define propertyStrongDictionary(s)   @property(nonatomic,strong)NSDictionary *s
#define propertyStrongArray(s)        @property(nonatomic,strong)NSArray *s
#define propertyStrongString(s)       @property(nonatomic,strong)NSString *s
#define propertyStrongMutableArray(s) @property(nonatomic,strong)NSMutableArray *s
#define propertyCopyArray(s)          @property(nonatomic,copy)NSArray *s
#define propertyCopyString(s)         @property(nonatomic,copy)NSString *s
#define propertyCopyDictionary(s)     @property(nonatomic,copy)NSDictionary *s
#define propertyCopyMutableArray(s)   @property(nonatomic,copy)NSMutableArray *s





/*************文件、路径、数据存储、default***********/


#define kFileManager   ([NSFileManager defaultManager])
#define kUserDefaults  ([NSUserDefaults standardUserDefaults])
//获取temp
#define kPathTemp     NSTemporaryDirectory()
//获取沙盒Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject]
//获取沙盒Cache
#define kPathCache    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) firstObject]
//本地加载
#define loadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define loadArray(file,type) [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define loadDict(file,type)  [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]




/***************通知*************/


#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define postNotification(_notificationName, _obj, _userInfoDictionary) [[NSNotificationCenter defaultCenter] postNotificationName: _notificationName object: _obj userInfo: _userInfoDictionary];




/*************观察者*************/

#define addObserver(_notificationName, _observer, _observerSelector, _obj) [[NSNotificationCenter defaultCenter] addObserver:_observer selector:@selector(_observerSelector) name:_notificationName object: _obj];

#define removeObserver(_observer) [[NSNotificationCenter defaultCenter] removeObserver: _observer];






/*************数据判断****************/


#define objectOrNull(obj) ((obj) ? (obj) : [NSNull null])
#define objectOrEmptyStr(obj) ((obj) ? (obj) : @"")

#define isNull(x)             (!x || [x isKindOfClass:[NSNull class]])
#define toInt(x)              (isNull(x) ? 0 : [x intValue])
#define isEmptyString(x)      (isNull(x) || [x isEqual:@""] || [x isEqual:@"(null)"])
#define isInValidString(x)    (isEmptyString(x) || [x isKindOfClass:[NSString class]] == NO)


#define validString(string)    (string != nil && [string isKindOfClass:[NSString class]] && ![string isEqualToString:@""])
#define safeString(string)     (validString(string)?string:@"")
#define hasString(string,key)  ([string rangeOfString:key].location!=NSNotFound)
#define validDict(f)           (f!=nil &&[f isKindOfClass:[NSDictionary class]])
#define validArray(f)          (f!=nil &&[f isKindOfClass:[NSArray class]]&&[f count]>0)
#define validNumber(f)         (f!=nil &&[f isKindOfClass:[NSNumber class]])
#define validClass(f,cls)      (f!=nil &&[f isKindOfClass:[cls class]])
#define validData(f)           (f!=nil &&[f isKindOfClass:[NSData class]])



/*************权限***********/


//获取相机权限状态
#define kCameraStatus  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo]
#define kCameraDenied  ((CameraStatus == AVAuthorizationStatusRestricted)||(CameraStatus == AVAuthorizationStatusDenied))
#define kCameraAllowed (!CameraDenyed)

//定位权限
#define kLocationStatus  [CLLocationManager authorizationStatus];
#define kLocationAllowed ([CLLocationManager locationServicesEnabled] && !((status == kCLAuthorizationStatusDenied) || (status == kCLAuthorizationStatusRestricted)))
#define kLocationDenied  (!LocationAllowed)

//消息推送权限
#define kPushClose   (([[UIDevice currentDevice].systemVersion floatValue]>=8.0f)?(UIUserNotificationTypeNone == [[UIApplication sharedApplication] currentUserNotificationSettings].types):(UIRemoteNotificationTypeNone == [[UIApplication sharedApplication] enabledRemoteNotificationTypes]))
#define kPushOpen    (!PushClose)





/****************单例*****************/

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}




/***************日志************/

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


#endif /* AppMacros_h */
