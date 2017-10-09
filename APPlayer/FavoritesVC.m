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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cbBottom = [[ControllerBar alloc]init];
    _menu = [[MenuView alloc]init];
    _menu.target = self;
    
    [self.view addSubview:_cbBottom.view];
    [self.view addSubview:_menu.view];
    self.navigationItem.title = @"收藏夹";
    
    _cbBottom.leftBtn = [[UIButton alloc]init];
    [_cbBottom.leftBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [_cbBottom.leftBtn addTarget:self action:@selector(jumpToSetting) forControlEvents:UIControlEventTouchUpInside];
    _cbBottom.leftBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    [_cbBottom.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cbBottom.view addSubview:_cbBottom.leftBtn];
    
    [_cbBottom.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.left.equalTo(_cbBottom.view.mas_left).with.offset(20);
    }];
    
    [_cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
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
    SettingMenuVC *smVC = [[SettingMenuVC alloc]init];
    smVC.preferredContentSize = CGSizeMake(300, 300);
    smVC.modalPresentationStyle = UIModalPresentationPopover;
    //  弹出视图的代理
    smVC.popoverPresentationController.delegate = self;
    
    //  弹出视图的参照视图、从哪弹出
    smVC.popoverPresentationController.sourceView = _cbBottom.leftBtn;

    //  弹出视图的尖头位置：参照视图底边中间位置
    smVC.popoverPresentationController.sourceRect = _cbBottom.leftBtn.bounds;

    //  弹出视图的箭头方向
    smVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;

    [self presentViewController:smVC animated:YES completion:nil];
    
}

- (BOOL) popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    return YES;
    
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    return UIModalPresentationNone;
    
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    
    NSLog(@"dismissed");
    
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
