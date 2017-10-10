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
    for (Video* video in videoArray) {
        if (![videoString isEqualToString:@""]||videoString!=nil) {
            videoString = [videoString stringByAppendingString:@" "];
        }
        videoString = [videoString stringByAppendingString:video.name];
    }
    return videoString;
}

//根据收藏夹名称查询所有视频列表
- (NSArray *)queryVideoByListName:(NSString *)listName{

    NSMutableArray *movieList = [[NSMutableArray alloc]init];
    NSArray *returnVideoList = [[NSMutableArray alloc]init];
    NSString *sql = @"SELECT * FROM videoList WHERE name = ?";
    FMResultSet *rs = [_db executeQuery:sql, listName];
    while ([rs next]) {
        NSString *name = [rs objectForColumn:@"videos"];
        [movieList addObject:name];
        NSString *string = [movieList firstObject];
        if ([name isKindOfClass:[NSNull class]] ) {
            return nil;
        }
        returnVideoList = [string componentsSeparatedByString:@" "];
    }

    return returnVideoList;
}

//查询收藏夹列表
- (NSMutableArray *)queryFavoriteList {
    NSString *sqlc = @"CREATE TABLE IF NOT EXISTS video (name TEXT,url TEXT)";
    NSString *sqlc1 = @"CREATE TABLE IF NOT EXISTS videoList (name TEXT,videos TEXT)";
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
    NSString *videoString = [self appendingString:nil :videos];
    NSString *sql = @"insert into videoList values (?,?)";
    [_db executeUpdate:sql, listName, videoString];
}

//删除收藏夹
- (void)deleteFavoriteList:(NSString *)listName {
    NSString *sql = @"delete FROM videoList WHERE name = ?";
    [_db executeUpdate:sql, listName];
}

//更新收藏夹中的视频
- (void)updateVideoToFavoriteList:(NSString *)listName :(NSMutableArray *)videos :(BOOL)isDelete {
    NSString *sql = @"select * from videoList where name = ?";
    FMResultSet *rs = [_db executeQuery:sql, listName];
    NSString *videoString = [[NSString alloc]init];
    //判断是否是删除视频
    if (!isDelete) {
        while ([rs next]) {
            videoString = [rs objectForColumn:@"videos"];
        }
    }
    if ([videoString isKindOfClass:[NSNull class]] ) {
        videoString = @"";
    }
    videoString = [self appendingString:videoString :videos];
    NSString *sql1 = @"update videoList set videos = ? where name = ?";
    [_db executeUpdate:sql1, videoString ,listName];
}

//从收藏夹中删除视频
- (void)removeVideoFromFavoriteList:(NSString *)listName :(Video *)video {
    NSMutableArray *videoArray = [self queryVideoByListName:listName];
    NSIndexSet *indexSet =
    [videoArray indexesOfObjectsPassingTest:^BOOL(NSString *  _Nonnull var, NSUInteger idx, BOOL * _Nonnull stop) {
        return [var isEqualToString:video.name];
    }];
    [videoArray removeObjectsAtIndexes:indexSet];
    [self updateVideoToFavoriteList:listName :videoArray :YES];
}



@end
