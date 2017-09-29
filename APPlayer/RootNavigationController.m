//
//  RootNavigationController.m
//  APPlayer
//
//  Created by lavanille on 2017/9/29.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "RootNavigationController.h"
#import "FavoritesVC.h"
@interface RootNavigationController ()

@end

@implementation RootNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    // 获取topCtl
    UIViewController  *ctl = self.topViewController;
    // 进行后续区分
    if([ctl isKindOfClass:[UIViewController class]]){
        
        return UIInterfaceOrientationMaskLandscape;
    }
    else {
        
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)shouldAutorotate
{
    return true;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 获取topCtl
    UIViewController  *ctl = viewController;
    // 在进入之前强制旋转设备
    if([ctl isKindOfClass:[UIViewController class]]){
        
        [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }
    [super pushViewController:viewController animated:animated];
}



// 强制转屏
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
