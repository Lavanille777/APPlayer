//
//  FavoritesInnerVC.m
//  APPlayer
//  收藏夹内页
//  Created by lavanille on 2017/9/28.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "FavoritesInnerVC.h"

@interface FavoritesInnerVC ()
@end

@implementation FavoritesInnerVC

//页面即将显示时刷新列表
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    _menu.nameList = [_sqlManager queryVideoByListName:_ListName];
    [self.view layoutIfNeeded];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景以及模糊
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image=[UIImage imageNamed:@"backgroud"];
    [self.view insertSubview:imageView atIndex:0];
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEfView.alpha = 0.9;
    visualEfView.frame =self.view.bounds;
    [imageView addSubview:visualEfView];
    
    self.navigationItem.title = _ListName;
    _sqlManager = [SQLManager initSqlManager];
    //旋转木马菜单
    _menu = [[MenuView alloc]init];
    _menu.superviewName = @"FavoritesInnerVC";
    _menu.target = self;
    _menu.nameList = [_sqlManager queryVideoByListName:_ListName];
    _menu.listName = _ListName;
    [self.view addSubview:_menu.view];
    //底部控制条
    _cbBottom = [[ControllerBar alloc]init];
    [self.view addSubview:_cbBottom.view];
    //布局开始
    //底部控制条布局
    [_cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, autosizePad10_5(97)));
    }];
    //旋转木马菜单布局
    [_menu.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, autosizePad10_5(560)));
    }];
    //布局结束
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 跳转至播放页方法
-(void)jump: (id)sender :(id)sender2{
    self.PVC = [[PlayerVC alloc]init];
    self.PVC.urlList = sender;
    self.PVC.playURL = sender2;
    [self.navigationController pushViewController:self.PVC animated:true];
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
