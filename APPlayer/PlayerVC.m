//
//  PlayerVC.m
//  APPlayer
//
//  Created by lavanille on 2017/9/28.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "PlayerVC.h"

@interface PlayerVC ()

@end

@implementation PlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ControllerBar *cbBottom = [[ControllerBar alloc]init];
    cbBottom.leftBtn = [[UIButton alloc]init];
    cbBottom.centerBtn = [[UIButton alloc]init];
    cbBottom.rightBth = [[UIButton alloc]init];
    [cbBottom.leftBtn setTitle:@"上一集" forState:UIControlStateNormal];
    [cbBottom.centerBtn setTitle:@"播放" forState:UIControlStateNormal];
    [cbBottom.rightBth setTitle:@"下一集" forState:UIControlStateNormal];
    cbBottom.leftBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    cbBottom.centerBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    cbBottom.rightBth.titleLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:cbBottom.view];
    [self.view addSubview:cbBottom.leftBtn];
    [self.view addSubview:cbBottom.centerBtn];
    [self.view addSubview:cbBottom.rightBth];
    
    
    self.player = [[AVPlayer alloc] init];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [self.playerView.layer addSublayer:_playerLayer];
    
    
    [cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 97));
    }];
    [cbBottom.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cbBottom.view.mas_centerY);
        make.left.equalTo(cbBottom.view.mas_left).with.offset(20);
    }];
    [cbBottom.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cbBottom.view.mas_centerY);
        make.centerX.equalTo(cbBottom.view);
    }];
    [cbBottom.rightBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cbBottom.view.mas_centerY);
        make.right.equalTo(cbBottom.view.mas_right).with.offset(-20);
    }];
    // Do any additional setup after loading the view.
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
