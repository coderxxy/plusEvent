//
//  YDBaseNavigationController.m
//  plusevent
//
//  Created by coderXY on 2024/3/30.
//

#import "YDBaseNavigationController.h"

@interface YDBaseNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, weak) id PopDelegate;

@end

@implementation YDBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
//        [self setNavigationBarHidden:YES animated:NO];
        //改变导航栏背景色
        if (@available(iOS 13.0, *)) {
            UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
            //设置背景色
            appearance.backgroundColor = XYThemeColor;//[UIColor whiteColor];
            //设置标题颜色
            appearance.titleTextAttributes = @{NSForegroundColorAttributeName: XYWhiteColor};
            //设置返回按键和返回字体为白色
            self.navigationBar.tintColor = XYWhiteColor;//[UIColor blackColor];
            self.navigationBar.standardAppearance = appearance;
            self.navigationBar.scrollEdgeAppearance = appearance;
            // 导航栏下划线隐藏
            [appearance setShadowColor:nil];
            self.navigationBar.standardAppearance = appearance;
            self.navigationBar.scrollEdgeAppearance = appearance;
        }
        else {
            UINavigationBar *bar = [UINavigationBar appearance];
//            [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav"] forBarMetrics:UIBarMetricsDefault];
            bar.barTintColor = XYThemeColor;//[UIColor whiteColor];
            bar.tintColor = XYWhiteColor;//[UIColor blackColor];
            [self.navigationController.navigationBar setTranslucent:YES];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont systemFontOfSize:15 weight:0.3], NSFontAttributeName, XYWhiteColor,nil];
            [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
}

- (void)config{
    //解决返回手势实效问题
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count >= 1) {
        viewController.navigationItem.leftBarButtonItem = [self backButton];
    }
    //解决push时隐藏tabbar
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    //
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (UIBarButtonItem *)backButton{
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
//   return [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
}

- (void)popSelf{
    [self popViewControllerAnimated:YES];
}


#pragma mark - 解决返回手势实效问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}


@end
