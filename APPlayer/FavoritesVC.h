//
//  FavoritesVC.h
//  APPlayer
//
//  Created by lavanille on 2017/9/27.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerBar.h"
#import "MenuView.h"
#import "SettingMenuVC.h"
#import "SQLManager.h"
@interface FavoritesVC : UIViewController <UIPopoverPresentationControllerDelegate>
@property (nonatomic,strong) MenuView *menu;
@property (nonatomic,strong) ControllerBar *cbBottom;
@property (nonatomic, strong) SQLManager *sqlManager;
@property (nonatomic, strong) NSMutableArray *favoriteList;
@end
