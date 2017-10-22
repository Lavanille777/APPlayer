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
static NSString *simpleTableIdentifier = @"videos";
- (void)viewWillAppear:(BOOL)animated{
    _favoriteList = [_sqlManager queryVideoByListName:_listName];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addVideo)];
    //从数据库中取得数组
    _sqlManager = [SQLManager initSqlManager];
    _favoriteList = [_sqlManager queryVideoByListName:_listName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    if (_favoriteList != nil) {
        [[cell textLabel]  setText:[_favoriteList objectAtIndex:indexPath.row]];
    }
    return cell;
}
#pragma mark - 添加视频方法
-(void)addVideo{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate: self];
    NSMutableArray *videoList = [[NSMutableArray alloc]init];
    imagePickerVc.columnNumber = 6;
    imagePickerVc.allowPickingMultipleVideo = YES;
    // 得到用户选择的照片.
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
        [_sqlManager addVideoToVideoList:_listName :videoList];
        [self viewWillAppear:true];
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
        [self viewWillAppear:true];
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
    }];
    return @[action0];
}


@end
