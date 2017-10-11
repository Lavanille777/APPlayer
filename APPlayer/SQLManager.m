//
//  SQLManager.m
//  APPlayer
//
//  Created by lavanille on 2017/10/9.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "SQLManager.h"

@implementation SQLManager

static SQLManager *manager = nil;
//创建单例数据库
+ (SQLManager *)initSqlManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        [manager createDataBaseIfNeeded];
    });
    return manager;
}

- (void)createDataBaseIfNeeded {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"APPlayer.sqlite"];
    _db = [FMDatabase databaseWithPath:filePath];
    NSLog(@"%@",[_db databasePath]);
 
    if (![_db open]) {
        NSLog(@"数据库打开失败！");
        return;
    }
}

//拼接字符串方法
- (NSString *)appendingString:(NSString *)videoString :(NSMutableArray *)videoArray {
    //将视频名称拼成一个字符串
    for (NSObject* video in videoArray) {
        if (![videoString isEqualToString:@""]&&videoString!=nil) {
            videoString = [videoString stringByAppendingString:@" "];
        }
        if ([video isKindOfClass:[Video class]]) {
            Video *temp = (Video *)video;
            videoString = [videoString stringByAppendingString:temp.name];
        }
        else if([video isKindOfClass:[NSString class]]){
            videoString = [videoString stringByAppendingString:(NSString *)video];
        }
    }
    return videoString;
}

//根据收藏夹名称查询所有视频列表
- (NSMutableArray *)queryVideoByListName:(NSString *)listName{

    NSMutableArray *returnVideoList = [[NSMutableArray alloc]init];
    NSString *sql = @"SELECT * FROM videoList WHERE name = ?";
    FMResultSet *rs = [_db executeQuery:sql, listName];
    while ([rs next]) {
        NSString *names = [rs objectForColumn:@"videos"];
        if ([names isKindOfClass:[NSNull class]] ) {
            return nil;
        }
        returnVideoList = [[names componentsSeparatedByString:@" "] mutableCopy];
    }
    
    return returnVideoList;
}

//查询收藏夹列表
- (NSMutableArray *)queryFavoriteList {
    NSString *sqlc = @"CREATE TABLE IF NOT EXISTS video (name TEXT primary key,url TEXT)";
    NSString *sqlc1 = @"CREATE TABLE IF NOT EXISTS videoList (name TEXT primary key,videos TEXT)";
    [_db executeUpdate:sqlc];
    [_db executeUpdate:sqlc1];
    NSMutableArray *favoriteList = [[NSMutableArray alloc]init];
    NSString *sql = @"select * from videoList";
    FMResultSet *rs = [_db executeQuery:sql];
    while ([rs next]) {
        NSString *name = [rs objectForColumn:@"name"];
        [favoriteList addObject:name];
    }
    return favoriteList;
}

//添加收藏夹
- (void)addFavoriteList:(NSString *)listName :(NSMutableArray *)videos {
    [self addVideoToVideoTable:videos];
    NSString *videoString = [self appendingString:@"" :videos];
    NSString *sql = @"replace into videoList values (?,?)";
    [_db executeUpdate:sql, listName, videoString];
}

//删除收藏夹
- (void)deleteFavoriteList:(NSString *)listName {
    NSString *sql = @"delete FROM videoList WHERE name = ?";
    [_db executeUpdate:sql, listName];
}

//添加视频到收藏夹
- (void)addVideoToVideoList:(NSString *)listName :(NSMutableArray *)videos {
    [self addVideoToVideoTable:videos];
    NSString *videoString = [[NSString alloc]init];
    videoString = @"";
    NSMutableArray *allVideos = [self videoListFilter:videos :listName];
    videoString = [self appendingString:videoString :allVideos];
    NSString *sql = @"update videoList set videos = ? where name = ?";
    [_db executeUpdate:sql, videoString ,listName];
}

//从收藏夹中删除视频
- (void)removeVideoFromFavoriteList:(NSString *)listName :(NSString *)video {
    NSMutableArray *videoArray = [self queryVideoByListName:listName];
    NSIndexSet *indexSet =
    [videoArray indexesOfObjectsPassingTest:^BOOL(NSString *  _Nonnull var, NSUInteger idx, BOOL * _Nonnull stop) {
        return [var isEqualToString:video];
    }];
    [videoArray removeObjectsAtIndexes:indexSet];
    NSString *videoString = [[NSString alloc]init];
    videoString = @"";
    videoString = [self appendingString:videoString :videoArray];
    NSString *sql = @"update videoList set videos = ? where name = ?";
    [_db executeUpdate:sql, videoString ,listName];
}

//将视频加入所有视频信息列表
- (void)addVideoToVideoTable:(NSMutableArray *)videos {
    NSString *sql = @"replace into video values(?,?)";
    for (Video *video in videos) {
        [_db executeUpdate:sql, video.name ,video.asset];
    }
}

//根据视频名称从所有视频信息列表中获取视频
- (Video *)queryVideoFromVideoTable:(NSString *)name {
    Video *video = [[Video alloc]init];
    NSString *sql = @"select * from video where name = ?";
    FMResultSet *rs = [_db executeQuery:sql, name];
    while ([rs next]) {
        video.name = [rs objectForColumn:@"name"];
        video.asset = [rs objectForColumn:@"url"];
    }
    return video;
}

//过滤添加的重复视频
- (NSMutableArray *)videoListFilter:(NSMutableArray *)addVideos :(NSString *)listName {
    NSMutableArray *videos = [self queryVideoByListName:listName];
    for (Video *video in addVideos) {
        if (![videos containsObject:(NSString *)video.name]) {
            NSString *name = video.name;
            [videos addObject:name];
        }
    }
    return videos;
}
@end
