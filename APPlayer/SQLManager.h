//
//  SQLManager.h
//  APPlayer
//
//  Created by lavanille on 2017/10/9.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDatabase.h>
#import "Video.h"
#import "VideoList.h"
@interface SQLManager : NSObject
+ (SQLManager *)initSqlManager;                                                     //获取sqlManager的单例方法
- (NSMutableArray *)queryVideoByListName:(NSString *)listName;                      //通过收藏夹名称获取所有视频
- (NSMutableArray *)queryFavoriteList;                                              //获取所有收藏夹
- (NSMutableArray *)videoListFilter:(NSMutableArray *)addVideos :(NSString *)listName; //过滤添加的重复视频
- (void)addFavoriteList:(NSString *)listName :(NSMutableArray *)videos;             //添加收藏夹
- (void)deleteFavoriteList:(NSString *)listName;                                    //删除收藏夹
- (void)addVideoToVideoList:(NSString *)listName :(NSMutableArray *)videos;         //添加视频到收藏夹
- (void)removeVideoFromFavoriteList:(NSString *)listName :(NSString *)video;           //从收藏夹中删除视频
- (NSString *)appendingString:(NSString *)videoString :(NSMutableArray *)videoArray; //拼接字符串方法
- (void)addVideoToVideoTable:(NSMutableArray *)videos;                              //将视频信息加入所有视频信息列表
- (Video *)queryVideoFromVideoTable:(NSString *)name;                               //根据视频名称从所有视频信息列表中获取视频
@property (strong,nonatomic) FMDatabase *db;

@end
