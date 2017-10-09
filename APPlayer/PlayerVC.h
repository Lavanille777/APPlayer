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

@interface PlayerVC : UIViewController
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerLayer *playerLayer;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) ControllerBar *cbBottom;
@property (nonatomic) BOOL playOrPauseFlag;
@property (nonatomic ,strong) NSURL *getURL;
@end
