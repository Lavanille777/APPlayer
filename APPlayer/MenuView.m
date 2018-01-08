//
//  MenuView.m
//  APPlayer
//  选集旋转木马视图
//  Created by lavanille on 2017/9/27.
//  Copyright © 2017年 lavanille. All rights reserved.
//

#import "MenuView.h"
#import "FavoritesInnerVC.h"
@interface MenuView () <iCarouselDelegate,iCarouselDataSource>

@end

@implementation MenuView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sqlManager = [SQLManager initSqlManager];
    //布局 使用masonry布局似乎会出现问题
    _iCarouselview = [[iCarousel alloc] initWithFrame:CGRectMake(0,autosizePad10_5(-150),self.view.frame.size.width,self.view.frame.size.height)];
    //设置显示效果类型
    _iCarouselview.type = iCarouselTypeCoverFlow;
    //设置代理
    _iCarouselview.dataSource = self;
    _iCarouselview.delegate = self;
    [self.view addSubview:_iCarouselview];
    if ([self.superviewName isEqualToString:@"FavoritesInnerVC"]) {
        [self resolveVideo];
    }
    
}

- (void)resolveVideo {
    
    _urlList = [[NSMutableArray alloc]init];
    PHImageManager *manager = [PHImageManager defaultManager];
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    
    for (NSString *str in _nameList) {
        _curVideo = [_sqlManager queryVideoFromVideoTable:str];
        if (_curVideo!=nil&&_curVideo.asset!=nil){
            PHFetchResult *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[_curVideo.asset] options:nil];
            PHAsset *asset = [assets firstObject];
            [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                if(urlAsset)
                {
                    [_urlList addObject:urlAsset.URL];
                }
                else
                {
                    [_sqlManager removeVideoFromFavoriteList:_listName :_curVideo.name];
                    [_nameList removeObjectAtIndex:[_nameList indexOfObject:str]];
                    [self.iCarouselview reloadData];
                }
            }];
        }
        else {
            NSLog(@"为空");
        }
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    //页面刷新
    [_iCarouselview reloadData];
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return [_nameList count];
}

- (void)tempJump{
    if ([self.superviewName isEqualToString:@"FavoritesInnerVC"]) {
        if (_url != nil && _urlList != nil) {
            [_target performSelector:@selector(jump::) withObject:_urlList withObject:_url];
        }
    }
    else if([self.superviewName isEqualToString:@"FavoritesVC"]){
        [_target performSelector:@selector(jump:) withObject:_str];
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    _str = [_nameList objectAtIndex:index];
    if (_urlList  != nil) {
        _url = [_urlList objectAtIndex:index];
    }
    [self tempJump];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    _label = nil;
    if (view == nil)
    {
        view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, autosizePad10_5(450.0f), autosizePad10_5(450.0f))];
        if([_nameList count] > 0)
        {
            Video *video = [_sqlManager queryVideoFromVideoTable:[_nameList objectAtIndex:index]];
            PHImageManager *manager = [PHImageManager defaultManager];
            PHImageRequestOptions*options = [[PHImageRequestOptions alloc]init];
            
            options.deliveryMode=PHImageRequestOptionsDeliveryModeFastFormat;
            //解析封面图片
            if (video.asset!=nil) {
                PHFetchResult *assets = [PHAsset fetchAssetsWithLocalIdentifiers:@[video.asset] options:nil];
                PHAsset *asset = [assets firstObject];
                [manager requestImageForAsset:asset targetSize:CGSizeMake(autosizePad10_5(900.0f), autosizePad10_5(900.0f)) contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage *resultImage, NSDictionary *info)
                 {
                     ((UIImageView *)view).image = resultImage;
                 }];
            }
            else {
                ((UIImageView *)view).backgroundColor = [UIColor blueColor];
                
            }
            
            _label = [[UILabel alloc] init];
            _label.backgroundColor = [UIColor clearColor];
            _label.font = [_label.font fontWithSize:50];
            _label.tag = 1;
            _label.frame = CGRectMake(0, view.frame.size.height + autosizePad10_5(10), view.frame.size.width, autosizePad10_5(50));
            _label.textAlignment = NSTextAlignmentCenter;
            [view addSubview:_label];
            [self.view addSubview:view];
        }
    }
    else
    {
        _label = (UILabel *)[view viewWithTag:1];
    }
//    carousel.name = [_nameList objectAtIndex:index];
    _label.text = [_nameList objectAtIndex:index];
    return view;
}


#pragma mark iCarouselDelegate
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //设置是否实现旋转木马效果
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //设置没个界面直接的间隙
            return value * 2.5f;
        }
        default:
        {
            return value;
        }
    }
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
