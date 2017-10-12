//
//  Video.h
//  APPlayer
//  视频实体
//  Created by lavanille on 2017/10/9.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property (nonatomic, strong) NSString *name;    //视频名称
@property (nonatomic, strong) NSString *asset;   //视频本地路径
@end
