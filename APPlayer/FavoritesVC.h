//
//  FavoritesVC.h
//  APPlayer
//  收藏夹页，主页
//  Created by lavanille on 2017/9/27.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerBar.h"
#import "MenuView.h"
#import "SettingMenuVC.h"
#import "SQLManager.h"
@interface FavoritesVC : UIViewController <UIPopoverPresentationControllerDelegate>
@property (nonatomic,strong) MenuView *menu;                        //旋转木马菜单
@property (nonatomic,strong) ControllerBar *cbBottom;               //底部控制条
@property (nonatomic, strong) NSMutableArray *favoriteList;         //菜单上显示的列表
@property (nonatomic, strong) SQLManager *sqlManager;

@end
