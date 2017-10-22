//
//  FavoritesManageVC.h
//  APPlayer
//  收藏夹管理页
//  Created by lavanille on 2017/10/9.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FavoriteInnerManageVC.h"
#import "SQLManager.h"
#import <TZImagePickerController.h>
@interface FavoritesManageVC : UITableViewController
@property (nonatomic, strong) NSMutableArray *favoriteList;     //收藏夹列表
@property (nonatomic, strong) SQLManager *sqlManager;
@end
