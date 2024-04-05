//
//  UIDevice+extension.h
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (extension)
/** 是否刘海屏 */
+ (BOOL)isSafeAreaMobile;
/** 顶部 安全区域 */
+ (CGFloat)safeTopHeight;
/** 底部安全区域 */
+ (CGFloat)safeBottomHeight;
/** 导航栏高度 包含安全区域, 不包含状态栏 */
+ (CGFloat)navBarHeight;
/** 状态栏高度 包含安全区域 */
+ (CGFloat)statusHeight;
/** tabbbar height */
+ (CGFloat)tabbarHeight;
@end

NS_ASSUME_NONNULL_END
