//
//  PlayerVC.h
//  APPlayer
//
//  Created by lavanille on 2017/9/28.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "ControllerBar.h"
#import <Photos/Photos.h>
#import "SQLManager.h"
#import "Video.h"
@interface PlayerVC : UIViewController
- (void)getURLWithResultHandler:(void (^)())resultHandler;
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerLayer *playerLayer;
@property (nonatomic ,strong) UIView *PlayerView;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) ControllerBar *cbBottom;
@property (nonatomic) BOOL playOrPauseFlag;
@property (nonatomic ,strong) NSMutableArray *nameList;
@property (nonatomic ,strong) NSString *curName;
@property (nonatomic ,strong) NSURL *playURL;
@end
