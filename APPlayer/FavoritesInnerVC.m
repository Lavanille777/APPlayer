//
//  FavoritesInnerVC.m
//  APPlayer
//  收藏夹选集页
//  Created by lavanille on 2017/9/28.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "FavoritesInnerVC.h"
#import "PlayerVC.h"
@interface FavoritesInnerVC ()
@end

@implementation FavoritesInnerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _ListName;
    _menu = [[MenuView alloc]init];
    _menu.target = self;
    [self.view addSubview:_menu.view];
    ControllerBar *cbBottom = [[ControllerBar alloc]init];
    [self.view addSubview:cbBottom.view];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)jump: (id)sender{
    PlayerVC *PVC = [[PlayerVC alloc]init];
    [self.navigationController pushViewController:PVC animated:true];
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
