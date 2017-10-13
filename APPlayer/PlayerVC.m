//
//  PlayerVC.m
//  APPlayer
//  播放页
//  Created by lavanille on 2017/9/28.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "PlayerVC.h"

@interface PlayerVC ()
@end

@implementation PlayerVC
- (void)viewWillAppear:(BOOL)animated {
    //页面即将显示时视频为暂停(或停止)状态
    _playOrPauseFlag = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - 播放器初始化
- (AVPlayer *)player:(AVPlayerItem*)item {
    if (_player == nil) {
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
        _player.volume = 1.0; // 默认最大音量
    }
    return _player;
}
#pragma mark - 播放器视图初始化
- (UIView* )PlayerView{
    UIView *PlayerView = [[UIView alloc]init];
    //获取视频本地URL
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:_getURL];
    _player = [self player: item];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //播放器视图布局
    _playerLayer.frame = CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 570);
    _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [PlayerView.layer addSublayer:_playerLayer];
    return PlayerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //底部控制条、上一集按钮、下一集按钮
    _cbBottom = [[ControllerBar alloc]init];
    _cbBottom.leftBtn = [[UIButton alloc]init];
    _cbBottom.centerBtn = [[UIButton alloc]init];
    _cbBottom.rightBth = [[UIButton alloc]init];
    [_cbBottom.leftBtn setTitle:@"上一集" forState:UIControlStateNormal];
    [_cbBottom.centerBtn setTitle:@"播放" forState:UIControlStateNormal];
    [_cbBottom.rightBth setTitle:@"下一集" forState:UIControlStateNormal];
    _cbBottom.leftBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _cbBottom.centerBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _cbBottom.rightBth.titleLabel.font = [UIFont systemFontOfSize:30];
    [_cbBottom.centerBtn addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cbBottom.view];
    [self.view addSubview:_cbBottom.leftBtn];
    [self.view addSubview:_cbBottom.centerBtn];
    [self.view addSubview:_cbBottom.rightBth];
    
    UIView *playerView = [self PlayerView];
    [self.view addSubview:playerView];
    //布局开始
    //底部控制条布局
    [_cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 97));
    }];
    //上一集按钮布局
    [_cbBottom.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.left.equalTo(_cbBottom.view.mas_left).with.offset(20);
    }];
    //播放暂停按钮布局
    [_cbBottom.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.centerX.equalTo(_cbBottom.view);
    }];
    //下一集按钮布局
    [_cbBottom.rightBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.right.equalTo(_cbBottom.view.mas_right).with.offset(-20);
    }];
    //布局结束
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 播放或暂停方法
-(void)playOrPause{
    if(_playOrPauseFlag==YES)
    {
        [_player play];
        [_cbBottom.centerBtn setTitle:@"暂停" forState:UIControlStateNormal];
        _playOrPauseFlag=NO;
    }
    else{
        [_player pause];
        [_cbBottom.centerBtn setTitle:@"播放" forState:UIControlStateNormal];
        _playOrPauseFlag=YES;
    }
}

@end
