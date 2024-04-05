//
//  Macro.h
//  WorkCalendar
//
//  Created by coderXY on 2022/6/11.
//

#ifndef Macro_h
#define Macro_h

#define KSCREENWIDTH        [UIScreen mainScreen].bounds.size.width         //  宽度
#define KSCREENHEIGHT       [UIScreen mainScreen].bounds.size.height        //  高度
#define kwRATIO             KSCREENWIDTH/414.0
#define khRATIO             KSCREENHEIGHT/736.0

// 屏幕rect
#define XYSCREEN_BOUNDS ([UIScreen mainScreen].bounds)
// 屏幕宽度
#define XYSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
// 屏幕高度
#define XYSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// 屏幕分辨率
#define XYSCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

#define kIs_iphone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIs_iPhoneX KSCREENWIDTH >=375.0f && KSCREENHEIGHT >=812.0f&& kIs_iphone
#define kBottomSafeHeight (CGFloat)(kIs_iPhoneX?(34.0):(0))                         //底部安全区域远离高度/
#define kStatusBarHeight (CGFloat)(kIs_iPhoneX?(44.0):(20.0))   ///状态栏高度
#define kNavBarHeight (44)                                      ///导航栏高度
#define kNavBarAndStatusBarHeight (CGFloat)(kIs_iPhoneX?(88.0):(64.0)) ///状态栏和导航栏总高度/

#define XY_Img(imgName)       [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#define XY_FONTVALUE(fontValue,weightValue) [UIFont systemFontOfSize:fontValue weight:weightValue]

//字体设置
#define XY_FontSize(value)              [UIFont systemFontOfSize:value]
#define XYFont_PF_Light(fontSize)       [UIFont fontWithName:@"PingFangSC-Light" size:fontSize]
#define XYFont_PF_Ultralight(fontSize)  [UIFont fontWithName:@"PingFangSC-Ultralight" size:fontSize]
// 苹方常规
#define XYFont_PF_Regular(fontSize)     [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize]
// 苹方粗体
#define XYFont_PF_Semibold(fontSize)    [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize]
#define XYFont_PF_Thin(fontSize)        [UIFont fontWithName:@"PingFangSC-Thin" size:fontSize]
#define XYFont_PF_Medium(fontSize)      [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize]
// 统一字体大小
#define XYTitleFont                     XY_FontSize(15)
#define XYTextFont                      XY_FontSize(15)
#define XYBtnTitleFont                  XY_FontSize(13)

#define XYRGB_GGCOLOR(r,g,b)            [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(1.0)]
#define XYRGBA_GGCOLOR(r,g,b,p)         [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(p)]
// 形如 RGB_HEX(0xFDFDFD, 1.0f) 的颜色定义
#define XYRGB_HEX(rgbValue, a) \
    [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                    green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
                     blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 \
                    alpha:(a)]
// 默认颜色
#define XYHexStrColor(hexStr)       [UIColor colorWithHexString:hexStr]
#define XYHEXCOLOR(hexStr, al)   [UIColor colorWithHexString:hexStr alpha:al]
#define XYClearColor                [UIColor clearColor]
#define XYThemeColor                [UIColor colorWithHexString:@"#1428A8"]
#define XYWhiteColor                [UIColor colorWithHexString:@"#ffffff"]
#define XYlightGrayColor            [UIColor colorWithHexString:@"#eeeeee"]
#define XYPlaceolderColor           [UIColor colorWithHexString:@"#bebec3"]
#define XYLineColor                 [UIColor colorWithHexString:@"#dfdfdf"]
#define XYBGColor                   [UIColor colorWithHexString:@"#f7f7f7"]
#define XYTextColor                 [UIColor colorWithHexString:@"#333333"]
#define XYTitleColor                [UIColor colorWithHexString:@"#696969"]


#define XYIsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))
//字符串是否为空
#define XYkStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define XYkArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define XYkDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define XYkObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//自定义打印log方法
#ifdef DEBUG
    #define XY_Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define XY_Log(...)
#endif

//宏定义
#ifndef weakify

#define weakify(o) __weak typeof(o)  weak##o = o;
#define strongify(o) __strong typeof(o) o = weak##o;

#endif

#define KEventDBName @"KEventDBName"

#endif /* Macro_h */
