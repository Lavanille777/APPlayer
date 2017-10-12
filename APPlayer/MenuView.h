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
@property (nonatomic) id target;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) NSString *str;
@property (nonatomic, strong) Video *curVideo;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSMutableArray *nameList;
@property (nonatomic, strong) iCarousel *iCarouselview;
@property (nonatomic, strong) NSMutableArray *assetArray;
@property (nonatomic, strong) SQLManager *sqlManager;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end
