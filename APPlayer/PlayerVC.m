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
    [super viewWillAppear:YES];
    //页面即将显示时视频为暂停(或停止)状态
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
    _PlayerView = [[UIView alloc]init];
    _playerItem = [[AVPlayerItem alloc] initWithURL:_playURL];
    _player = [self player: _playerItem];
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    //播放器视图布局
    _playerLayer.frame = CGRectMake(0, rectStatus.size.height+self.navigationController.navigationBar.frame.size.height, SCREEN_W, SCREEN_H - rectStatus.size.height - self.navigationController.navigationBar.frame.size.height - autosizePad10_5(97));
    _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [_PlayerView.layer addSublayer:_playerLayer];
    return _PlayerView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _playOrPauseFlag = YES;
    //底部控制条、上一集按钮、下一集按钮
    _cbBottom = [[ControllerBar alloc]init];
    _cbBottom.leftBtn = [[UIButton alloc]init];
    _cbBottom.centerBtn = [[UIButton alloc]init];
    _cbBottom.rightBth = [[UIButton alloc]init];
    [_cbBottom.leftBtn setTitle:@"上一集" forState:UIControlStateNormal];
    [_cbBottom.centerBtn setTitle:@"播放" forState:UIControlStateNormal];
    [_cbBottom.rightBth setTitle:@"下一集" forState:UIControlStateNormal];
    _cbBottom.leftBtn.titleLabel.font = [UIFont systemFontOfSize:autosizePad10_5(30)];
    _cbBottom.centerBtn.titleLabel.font = [UIFont systemFontOfSize:autosizePad10_5(30)];
    _cbBottom.rightBth.titleLabel.font = [UIFont systemFontOfSize:autosizePad10_5(30)];
    [_cbBottom.centerBtn addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
    [_cbBottom.leftBtn addTarget:self action:@selector(lastEpisode) forControlEvents:UIControlEventTouchUpInside];
    [_cbBottom.rightBth addTarget:self action:@selector(nextEpisode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cbBottom.view];
    [self.view addSubview:_cbBottom.leftBtn];
    [self.view addSubview:_cbBottom.centerBtn];
    [self.view addSubview:_cbBottom.rightBth];
    
    UIView *_PlayerView = [self PlayerView];
    [self.view addSubview:_PlayerView];
    //布局开始
    //底部控制条布局
    [_cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, autosizePad10_5(97)));
    }];
    //上一集按钮布局
    [_cbBottom.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.left.equalTo(_cbBottom.view.mas_left).with.offset(autosizePad10_5(20));
    }];
    //播放暂停按钮布局
    [_cbBottom.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.centerX.equalTo(_cbBottom.view);
    }];
    //下一集按钮布局
    [_cbBottom.rightBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.right.equalTo(_cbBottom.view.mas_right).with.offset(autosizePad10_5(-20));
    }];
    //布局结束
}
#pragma mark - 跳到上一集
- (void)lastEpisode {
    if ([_urlList indexOfObject:_playURL]!=0) {
        _playURL = [_urlList objectAtIndex:[_urlList indexOfObject:_playURL]-1];
    }
    else{
        _playURL = [_urlList objectAtIndex:[_urlList count]-1];
    }
    [self refreshPlayer];
}
#pragma mark - 跳到下一集
- (void)nextEpisode {
    if ([_urlList indexOfObject:_playURL]!=[_urlList count]-1) {
        _playURL = [_urlList objectAtIndex:[_urlList indexOfObject:_playURL]+1];
    }
    else{
        _playURL = [_urlList objectAtIndex:0];
    }
    [self refreshPlayer];
}
#pragma mark - 播放器刷新
- (void)refreshPlayer {
    _playOrPauseFlag = NO;
    [self playOrPause];
    _playerItem = [[AVPlayerItem alloc] initWithURL:_playURL];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
    [self.view layoutIfNeeded];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
