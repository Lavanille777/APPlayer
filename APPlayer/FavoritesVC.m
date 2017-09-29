//
//  FavoritesVC.m
//  APPlayer
//  收藏夹页，主页
//  Created by lavanille on 2017/9/27.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "FavoritesVC.h"
#import "FavoritesInnerVC.h"
#import "SettingMenuVC.h"
@interface FavoritesVC ()

@end

@implementation FavoritesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ControllerBar *cbBottom = [[ControllerBar alloc]init];
    _menu = [[MenuView alloc]init];
    _menu.target = self;
    [self.view addSubview:cbBottom.view];
    [self.view addSubview:_menu.view];
    self.navigationItem.title = @"收藏夹";
    cbBottom.leftBtn = [[UIButton alloc]init];
    [cbBottom.leftBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [cbBottom.leftBtn addTarget:self action:@selector(jumpToSetting) forControlEvents:UIControlEventTouchUpInside];
    cbBottom.leftBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [cbBottom.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cbBottom.view addSubview:cbBottom.leftBtn];
    
    [cbBottom.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cbBottom.view.mas_centerY);
        make.left.equalTo(cbBottom.view.mas_left).with.offset(20);
    }];
    
    [cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 97));
    }];
    [_menu.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 560));
    }];
    // Do any additional setup after loading the view.
}

-(void)jumpToSetting{
    [self.navigationController pushViewController:[[SettingMenuVC alloc]init] animated:true];
}

-(void)jump: (id)sender{
    FavoritesInnerVC *favI = [[FavoritesInnerVC alloc]init];
    favI.ListName = sender;
    [self.navigationController pushViewController:favI animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
