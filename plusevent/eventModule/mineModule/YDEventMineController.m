//
//  YDEventMineController.m
//  plusevent
//
//  Created by coderXY on 2024/3/31.
//

#import "YDEventMineController.h"

@interface YDEventMineController ()

@end

@implementation YDEventMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    MMDrawerController * mmdc = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [mmdc closeDrawerAnimated:YES completion:nil];
}

@end
