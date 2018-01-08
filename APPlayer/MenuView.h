//
//  MenuView.h
//  APPlayer
//
//  Created by lavanille on 2017/9/27.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel.h>
#import "SQLManager.h"
#import "Video.h"
#import <TZImagePickerController.h>
#import <Photos/Photos.h>
@interface MenuView : UIViewController
@property (nonatomic, weak) id target;                                  //将事件交给其他类处理
@property (nonatomic,strong) UILabel *label;                            //封面标题
@property (nonatomic,strong) NSString *str;                             //将标题交给收藏夹内页
@property (nonatomic, strong) Video *curVideo;                          //目前选中的视频
@property (nonatomic, strong) NSURL *url;                               //将视频地址交给播放器页
@property (nonatomic, strong) NSMutableArray *nameList;                 //旋转木马显示的名称列表
@property (nonatomic, strong) iCarousel *iCarouselview;                 //旋转木马视图
@property (nonatomic, strong) NSMutableArray *urlList;                  //视频地址列表
@property (nonatomic, strong) NSString *superviewName;                  //父视图名称，以判别如何跳转
@property (nonatomic, strong) NSString *listName;                       //收藏夹名称
@property (nonatomic, strong) SQLManager *sqlManager;
@end
