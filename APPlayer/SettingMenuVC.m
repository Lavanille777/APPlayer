//
//  SettingMenuVC.m
//  APPlayer
//  设置主菜单
//  Created by lavanille on 2017/9/29.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "SettingMenuVC.h"
#import "SystemAlbum.h"
#import "PlayerVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface SettingMenuVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSArray *titles;
@end

@implementation SettingMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = [[NSArray alloc]initWithObjects:@"所有视频",@"收藏夹管理",@"其他设置",nil];
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
    
    return [_titles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"AccountManager";
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
    if (row == 0) {
        
        // 1.判断相册是否可以打开
        if (![SystemAlbum isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
        // 2. 创建图片选择控制器
        SystemAlbum *ipc = [[SystemAlbum alloc] init];
        /**
         typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
         UIImagePickerControllerSourceTypePhotoLibrary, // 相册
         UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
         UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
         }
         */
        // 3. 设置打开照片相册类型(显示所有相簿)
        
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ipc.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie,(NSString *)kUTTypeVideo, nil];
        [ipc setVideoQuality:UIImagePickerControllerQualityTypeHigh];
        // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        // 照相机
        // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 4.设置代理
        ipc.delegate = self;
        // 5.modal出这个控制器
        
        [self presentViewController:ipc animated:YES completion:nil];
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //打印出字典中的内容
    NSLog(@"get the media info: %@", info);
    PlayerVC *pvc = [[PlayerVC alloc]init];
    pvc.getURL = [info objectForKey:UIImagePickerControllerMediaURL];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:pvc animated:true];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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
