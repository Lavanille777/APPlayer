//
//  SettingMenuVC.h
//  APPlayer
//
//  Created by lavanille on 2017/9/29.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingMenuVC : UITableViewController
@property (nonatomic) id target;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) id parentTarget;
@end
