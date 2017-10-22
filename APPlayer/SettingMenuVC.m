//
//  SettingMenuVC.m
//  APPlayer
//  设置主菜单（以pop的方式在主页弹出）
//  Created by lavanille on 2017/9/29.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "SettingMenuVC.h"
#import "PlayerVC.h"
#import "FavoritesManageVC.h"
#import "TZImagePickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface SettingMenuVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation SettingMenuVC
static NSString *simpleTableIdentifier = @"AccountManager";
- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = [[NSArray alloc]initWithObjects:@"收藏夹管理",@"其他设置",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    [[cell textLabel]  setText:[_titles objectAtIndex:indexPath.row]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if(row == 0){
        [self dismissViewControllerAnimated:true completion:nil];
        if ([self.presentingViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController*)self.presentingViewController;
            [nav pushViewController:[[FavoritesManageVC alloc]init] animated:YES];
        }
        else{
            [self presentViewController:[[FavoritesManageVC alloc]init] animated:YES completion:nil];
        }
    }
    
}

@end
