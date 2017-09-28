//
//  PlayerVC.h
//  APPlayer
//
//  Created by lavanille on 2017/9/28.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ControllerBar.h"

@interface PlayerVC : UIViewController
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerLayer *playerLayer;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@end
