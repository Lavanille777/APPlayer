//
//  ControllerBar.m
//  APPlayer
//  底部控制条
//  Created by lavanille on 2017/9/27.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "ControllerBar.h"

@interface ControllerBar ()

@end

@implementation ControllerBar

- (void)viewDidLoad {
    [super viewDidLoad];
    //控制条背景色
    self.view.backgroundColor = [UIColor blackColor];
    [self.view setAlpha:0.5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
