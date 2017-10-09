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
+ (SQLManager *)sqlManager {
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

//根据收藏夹名称查询所有视频列表
- (NSArray *)queryVideoByListName:(NSString *)listName{
    NSMutableArray *movieList = [[NSMutableArray alloc]init];
    NSArray *returnVideoList = [[NSMutableArray alloc]init];
    NSString *sql = @"SELECT * FROM movieList WHERE name = ?";
    FMResultSet *rs = [_db executeQuery:sql, listName];
    while ([rs next]) {
        NSString *name = [rs objectForColumn:@"videos"];
        [movieList addObject:name];
        NSString *string = [movieList firstObject];
        returnVideoList = [string componentsSeparatedByString:@" "];
    }
    return returnVideoList;
}

//查询收藏夹列表
- (NSMutableArray *)queryFavoriteList {
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
    NSString *videoString = [[NSString alloc]init];
    //将视频名称拼成一个字符串
    for (Video* video in videos) {
        if (videoString!=nil) {
            videoString = [videoString stringByAppendingString:@" "];
        }
        videoString = [videoString stringByAppendingString:video.name];
    }
    NSString *sql = @"insert into videoList values (?,?)";
    [_db executeUpdate:sql, listName, videoString];
}

//删除收藏夹
- (void)deleteFavoriteList:(NSString *)listName {
    NSString *sql = @"delete FROM videoList WHERE name = ?";
    [_db executeUpdate:sql, listName];
}


@end
