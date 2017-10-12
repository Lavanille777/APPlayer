//
//  FavoritesManageVC.m
//  APPlayer
//
//  Created by lavanille on 2017/10/9.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "FavoritesManageVC.h"

@interface FavoritesManageVC ()

@end

@implementation FavoritesManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addFavorite)];
    //从数据库获取列表
    _sqlManager = [SQLManager initSqlManager];
    _favoriteList = [_sqlManager queryFavoriteList];
 
}

- (void)addFavorite {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入收藏夹名称" preferredStyle:UIAlertControllerStyleAlert];
    
    //增加确定按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取输入框
        UITextField *TextField = alertController.textFields.firstObject;
        [self addVideos: TextField.text];
        [_sqlManager addFavoriteList:TextField.text :nil];
    }]];
    
    //增加取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"名称";
    }];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)addVideos: (NSString *)listName{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate: self];
    NSMutableArray *videoList = [[NSMutableArray alloc]init];
    imagePickerVc.columnNumber = 6;
    imagePickerVc.allowPickingMultipleVideo = YES;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        for (id asset in assets) {
            if ([asset isKindOfClass:[PHAsset class]]){
                Video *video = [[Video alloc]init];
                video.name = [asset valueForKey:@"filename"];
                video.asset = [asset valueForKey:@"localIdentifier"];
                [videoList addObject:video];
            }
            else{
                NSLog(@"不是");
            }
        }
        [_sqlManager addVideoToVideoList:listName :videoList];
        [self viewWillAppear:true];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
        [_sqlManager deleteFavoriteList:cell.textLabel.text];
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
        [self viewWillAppear:true];
    }];
    return @[action0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_favoriteList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"videos";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
        [[cell textLabel]  setText:[_favoriteList objectAtIndex:indexPath.row]];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    // Configure the cell...
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    FavoriteInnerManageVC *vil = [[FavoriteInnerManageVC alloc] init];
    vil.listName = cell.textLabel.text;
    [self.navigationController pushViewController:vil animated:true];
}

- (void)viewWillAppear:(BOOL)animated{
    _favoriteList = [_sqlManager queryFavoriteList];
    [self viewDidLoad];
    [self.tableView reloadData];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
