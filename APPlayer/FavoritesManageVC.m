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
static NSString *simpleTableIdentifier = @"videos";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //列表刷新
    _favoriteList = [_sqlManager queryFavoriteList];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addFavorite)];
    //从数据库获取列表
    _sqlManager = [SQLManager initSqlManager];
    _favoriteList = [_sqlManager queryFavoriteList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//开启cell编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//左滑出现删除选项
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *action0 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
        [_sqlManager deleteFavoriteList:cell.textLabel.text];
        // 收回左滑出现的按钮(退出编辑模式)
        tableView.editing = NO;
        [self viewWillAppear:YES];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    if (_favoriteList != nil) {
        [[cell textLabel]  setText:[_favoriteList objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath: indexPath];
    FavoriteInnerManageVC *vil = [[FavoriteInnerManageVC alloc] init];
    vil.listName = cell.textLabel.text;
    [self.navigationController pushViewController:vil animated:true];
}

#pragma mark - 添加收藏夹方法
- (void)addFavorite {
    //弹出输入收藏夹名称的提示框
    self.creatFavAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入收藏夹名称" preferredStyle:UIAlertControllerStyleAlert];
    FavoritesManageVC __weak *weakself = self;
    //增加确定按钮
    [self.creatFavAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取输入框
        UITextField *TextField = weakself.creatFavAlert.textFields.firstObject;
        //若输入字符串包含空格则弹出错误提示并不会创建收藏夹
        if([TextField.text containsString:@" "])
        {
            NSLog(@"不允许包含空格");
            weakself.forbidSpace = [UIAlertController alertControllerWithTitle:@"错误" message:@"不允许包含空格" preferredStyle:UIAlertControllerStyleAlert];
            [weakself.forbidSpace addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [weakself presentViewController:weakself.forbidSpace animated:YES completion:nil];
        }
        else{
            [weakself addVideos: TextField.text];
            [_sqlManager addFavoriteList:TextField.text :nil];
        }
    }]];
    //增加取消按钮
    [self.creatFavAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self.creatFavAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"名称";
    }];
    [self presentViewController:self.creatFavAlert animated:YES completion:nil];
    
}
#pragma mark - 添加视频方法
-(void)addVideos: (NSString *)listName{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate: self];
    NSMutableArray *videoList = [[NSMutableArray alloc]init];
    imagePickerVc.columnNumber = 6;
    imagePickerVc.allowPickingMultipleVideo = YES;
    imagePickerVc.allowPickingImage = NO;
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
                NSLog(@"不是PHAsset");
            }
        }
        [_sqlManager addVideoToVideoList:listName :videoList];
        [self viewWillAppear:YES];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}


@end
