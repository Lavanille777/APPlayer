//
//  VideoList.h
//  APPlayer
//  视频收藏夹实体
//  Created by lavanille on 2017/10/9.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoList : NSObject
@property (nonatomic, strong) NSString *name;               //收藏夹名称
@property (nonatomic, strong) NSString *listString;         //未分割的视频列表（一个用空格分割的字符串）
@property (nonatomic, strong) NSMutableArray *videoList;    //视频列表
@end
