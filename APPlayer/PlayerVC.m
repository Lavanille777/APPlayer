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

- (AVPlayer *)player:(AVPlayerItem*)item {
    if (_player == nil) {
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
        _player.volume = 1.0; // 默认最大音量
    }
    return _player;
}

- (UIView* )PlayerView{
    UIView *PlayerView = [[UIView alloc]init];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:_getURL];
    _player = [self player: item];
    CMTime duration = item.duration;// 获取视频总长度
    NSLog(@"lalala%f",CMTimeGetSeconds(duration));
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 80, [UIScreen mainScreen].bounds.size.width, 570);
    _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    [PlayerView.layer addSublayer:_playerLayer];
    return PlayerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _playOrPauseFlag = YES;
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
    
    [playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_top);
    }];
    [_cbBottom.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width, 97));
    }];
    [_cbBottom.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.left.equalTo(_cbBottom.view.mas_left).with.offset(20);
    }];
    [_cbBottom.centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.centerX.equalTo(_cbBottom.view);
    }];
    [_cbBottom.rightBth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cbBottom.view.mas_centerY);
        make.right.equalTo(_cbBottom.view.mas_right).with.offset(-20);
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
