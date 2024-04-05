//
//  AppDelegate.m
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import "AppDelegate.h"
#import "YDPluseventController.h"
#import "YDEventMineController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self keyboardEvent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    YDPluseventController *homeVC = [[YDPluseventController alloc] init];
    YDBaseNavigationController *navVC = [[YDBaseNavigationController alloc] initWithRootViewController:homeVC];
    //
    YDEventMineController *mineVC = [[YDEventMineController alloc] init];
    YDBaseNavigationController *mineNVC = [[YDBaseNavigationController alloc] initWithRootViewController:mineVC];
    //
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navVC leftDrawerViewController:mineNVC];
    drawerController.maximumLeftDrawerWidth = XYSCREEN_WIDTH/2;
    self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)keyboardEvent{
    //获取类库的单例变量
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    //控制整个功能是否启用
//    keyboardManager.enable = YES;
    //控制点击背景是否收起键盘
    keyboardManager.shouldResignOnTouchOutside = YES;
    //控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.shouldToolbarUsesTextFieldTintColor = NO;
    //有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.toolbarManageBehavior = IQAutoToolbarBySubviews;
    //控制是否显示键盘上的工具条
    keyboardManager.enableAutoToolbar = NO;
    //是否显示占位文字
    keyboardManager.shouldShowToolbarPlaceholder = NO;
    //设置占位文字的字体
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:13];
    //输入框距离键盘的距离
    keyboardManager.keyboardDistanceFromTextField = 10.0f;
}



@end
