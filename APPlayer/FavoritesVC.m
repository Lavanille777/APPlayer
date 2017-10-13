//
//  FavoritesVC.m
//  APPlayer
//  收藏夹页，主页
//  Created by lavanille on 2017/9/27.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "FavoritesVC.h"
#import "FavoritesInnerVC.h"

@interface FavoritesVC ()

@end

@implementation FavoritesVC

//页面即将显示时刷新列表
- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
    self.menu.nameList = [_sqlManager queryFavoriteList];
    [self.menu.iCarouselview reloadData];
    [self.view layoutIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收藏夹";
    _sqlManager = [SQLManager initSqlManager];
    //底部控制条及菜单按钮
    _cbBottom = [[ControllerBar alloc]init];
    [self.view addSubview:_cbBottom.view];
    _cbBottom.leftBtn = [[UIButton alloc]init];
    [_cbBottom.leftBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [_cbBottom.leftBtn addTarget:self action:@selector(jumpToSetting) forControlEvents:UIControlEventTouchUpInside];
    _cbBottom.leftBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [_cbBottom.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cbBottom.view addSubview:_cbBottom.leftBtn];
    //旋转木马菜单
    _menu = [[MenuView alloc]init];
    _menu.target = self;
    _menu.nameList = [_sqlManager queryFavoriteList];
    [self.view addSubview:_menu.view];
    
    //布局开始
    //设置菜单按钮布局
    [_cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 97));
    }];
    //设置菜单布局
    [_cbBottom.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.left.equalTo(_cbBottom.view.mas_left).with.offset(20);
    }];
    //旋转木马菜单布局
    [_menu.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 560));
    }];
    //布局结束
    
}
#pragma mark - 设置菜单弹出方法
-(void)jumpToSetting{
    SettingMenuVC *smVC = [[SettingMenuVC alloc]init];
    smVC.preferredContentSize = CGSizeMake(300, 300);
    smVC.modalPresentationStyle = UIModalPresentationPopover;
    smVC.target = self;
    //  弹出视图的代理
    smVC.popoverPresentationController.delegate = self;
    //  弹出视图的参照视图、从哪弹出
    smVC.popoverPresentationController.sourceView = _cbBottom.leftBtn;
    //  弹出视图的尖头位置：参照视图底边中间位置
    smVC.popoverPresentationController.sourceRect = _cbBottom.leftBtn.bounds;
    //  弹出视图的箭头方向
    smVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    [self.navigationController setDefinesPresentationContext:YES];
    [smVC setModalPresentationStyle:UIModalPresentationCurrentContext];
    [self presentViewController:smVC animated:YES completion:nil];
    
}
#pragma mark - 点击背景时设置菜单消失
- (BOOL) popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;
}
#pragma mark - 设置菜单不覆盖整个屏幕
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
#pragma mark - 当设置菜单消失时
//- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
//    NSLog(@"dismissed");
//}

#pragma mark - 跳转至收藏夹内页方法
-(void)jump: (id)sender{
    FavoritesInnerVC *favI = [[FavoritesInnerVC alloc]init];
    favI.ListName = sender;
    [self.navigationController pushViewController:favI animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
