//
//  SystemAlbum.m
//  APPlayer
//
//  Created by lavanille on 2017/9/30.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "SystemAlbum.h"

@interface SystemAlbum ()

@end

@implementation SystemAlbum

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // dismiss UIImagePickerController
    //[self dismissViewControllerAnimated:YES completion:nil];
    // 选择的图片信息存储于info字典中
    
    //NSLog(@"啦啦啦%@", info);
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // dismiss UIImagePickerController
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
