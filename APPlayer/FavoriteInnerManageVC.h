//
//  favoriteInnerManageVC.h
//  APPlayer
//
//  Created by lavanille on 2017/10/10.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TZImagePickerController.h>
#import "SQLManager.h"
#import <Photos/Photos.h>
@interface FavoriteInnerManageVC : UITableViewController
@property (nonatomic, strong) NSMutableArray *favoriteList;
@property (nonatomic, strong) NSString *listName;
@property (nonatomic, strong) SQLManager *sqlManager;
@end
