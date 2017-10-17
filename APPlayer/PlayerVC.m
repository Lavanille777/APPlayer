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
    [self getURLWithResultHandler:^{
         //获取视频本地URL
        _playerItem = [[AVPlayerItem alloc] initWithURL:_playURL];
        _player = [self player: _playerItem];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        //播放器视图布局
        _playerLayer.frame = CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 680);
        _playerLayer.backgroundColor = [UIColor blackColor].CGColor;
        [_PlayerView.layer addSublayer:_playerLayer];
    }];
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
    _cbBottom.leftBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _cbBottom.centerBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    _cbBottom.rightBth.titleLabel.font = [UIFont systemFontOfSize:30];
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
#pragma mark - 根据名称获取地址
- (void)getURLWithResultHandler:(void (^)())resultHandler{
    SQLManager *sqlManager = [SQLManager initSqlManager];
    Video *curVideo = [sqlManager queryVideoFromVideoTable:_curName];
    if (curVideo!=nil&&curVideo.asset!=nil){
        PHImageManager *manager = [PHImageManager defaultManager];
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        PHFetchResult *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[curVideo.asset] options:nil];
        PHAsset *asset = [assets firstObject];

        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            _playURL = urlAsset.URL;
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_sync(mainQueue,^{
                
                resultHandler();
            });
            
        }];
        
    }
}
#pragma mark - 跳到上一集
- (void)lastEpisode {
    if ([_nameList indexOfObject:_curName]!=0) {
        _curName = [_nameList objectAtIndex:[_nameList indexOfObject:_curName]-1];
    }
    else{
        _curName = [_nameList objectAtIndex:[_nameList count]-1];
    }
    [self refreshPlayer];
}
#pragma mark - 跳到下一集
- (void)nextEpisode {
    if ([_nameList indexOfObject:_curName]!=[_nameList count]-1) {
        _curName = [_nameList objectAtIndex:[_nameList indexOfObject:_curName]+1];
    }
    else{
        _curName = [_nameList objectAtIndex:0];
    }
    [self refreshPlayer];
}
#pragma mark - 播放器刷新
- (void)refreshPlayer {
    _playOrPauseFlag = NO;
    [self playOrPause];
    [self getURLWithResultHandler:^{
        _playerItem = [[AVPlayerItem alloc] initWithURL:_playURL];
        [_player replaceCurrentItemWithPlayerItem:_playerItem];
        [self.view layoutIfNeeded];
    }];
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
