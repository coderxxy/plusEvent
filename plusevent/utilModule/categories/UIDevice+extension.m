//
//  UIDevice+extension.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "UIDevice+extension.h"

@implementation UIDevice (extension)
+ (BOOL)isSafeAreaMobile {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        CGFloat safeAreaTop = keyWindow.safeAreaInsets.top;
        return safeAreaTop > 0;
    }
    return NO;
}
+ (CGFloat)safeTopHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        CGFloat safeAreaTop = keyWindow.safeAreaInsets.top;
        return safeAreaTop;
    }
    return 0;
}
+ (CGFloat)safeBottomHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        CGFloat safeAreaBottom = keyWindow.safeAreaInsets.bottom;
        return safeAreaBottom;
    }
    return 0;
}
+ (CGFloat)navBarHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        CGFloat safeAreaTop = keyWindow.safeAreaInsets.top;
        return safeAreaTop>0?safeAreaTop+44.0:44.0;
    }
    return 44.0;
}
+ (CGFloat)statusHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        CGFloat safeAreaTop = keyWindow.safeAreaInsets.top;
        return safeAreaTop+20;
    }
    return 20.0;
}
+ (CGFloat)tabbarHeight {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        CGFloat safeAreaBottom = keyWindow.safeAreaInsets.bottom;
        return safeAreaBottom+49.0;
    }
    return 49.0;
}
@end
