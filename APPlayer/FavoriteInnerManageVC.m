//
//  favoriteInnerManageVC.m
//  APPlayer
//
//  Created by lavanille on 2017/10/10.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "FavoriteInnerManageVC.h"

@interface FavoriteInnerManageVC ()

@end

@implementation FavoriteInnerManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addVideo)];
    
    //从数据库中取得数组
    _sqlManager = [SQLManager initSqlManager];
    _favoriteList = [_sqlManager queryVideoByListName:_listName];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if (_favoriteList == nil) {
        return 1;
    }
    return [_favoriteList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"videos";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    if (_favoriteList != nil) {
        [[cell textLabel]  setText:[_favoriteList objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(void)addVideo{
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
                video.asset = asset;
                [videoList addObject:video];
            }
            else{
                NSLog(@"不是");
            }
        }
        [_sqlManager addVideoToVideoList:_listName :videoList];
    }];
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, id asset) {
        
            if ([asset isKindOfClass:[PHAsset class]]){
                NSLog(@"asset isKindOfClass:[PHAsset class]");
            }
            else{
                NSLog(@"不是");
            }
        
                
    }];

    [self presentViewController:imagePickerVc animated:YES completion:nil];
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
        [_sqlManager removeVideoFromFavoriteList:_listName :(NSString *)cell.textLabel.text];
        [self.tableView reloadData];
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
    }];
    return @[action0];
}


- (void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
    [self.view layoutIfNeeded];
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
