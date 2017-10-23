//
//  SettingMenuVC.h
//  APPlayer
//  设置菜单页
//  Created by lavanille on 2017/9/29.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingMenuVC : UITableViewController
@property (nonatomic, weak) id target;
@property (nonatomic, strong) NSArray *titles;          //菜单标题
@end
