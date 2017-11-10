//
//  FavoritesInnerVC.h
//  APPlayer
//  收藏夹内页
//  Created by lavanille on 2017/9/28.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerBar.h"
#import "MenuView.h"
#import "SQLManager.h"
#import "PlayerVC.h"
@interface FavoritesInnerVC : UIViewController
@property (nonatomic,strong) NSString *ListName;            //收藏夹名称
@property (nonatomic,strong) MenuView *menu;                //旋转木马菜单
@property (nonatomic,strong) ControllerBar *cbBottom;       //底部控制条
@property (nonatomic, strong) PlayerVC *PVC;                //播放器页
@property (nonatomic, strong) SQLManager *sqlManager;
@end
