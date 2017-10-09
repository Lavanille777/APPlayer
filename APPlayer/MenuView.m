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
    iCarousel *iCarouselview = [[iCarousel alloc] initWithFrame:CGRectMake(0,-150,self.view.frame.size.width,self.view.frame.size.height)];
    //设置显示效果类型
    iCarouselview.type = iCarouselTypeCoverFlow;
    //设置代理
    iCarouselview.dataSource = self;
    iCarouselview.delegate = self;
    [self.view addSubview:iCarouselview];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 10;
}

- (void)tempJump{
      [_target performSelector:@selector(jump:) withObject:_str];
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *) carousel{
    UIView *view = carousel.currentItemView;
    _str = carousel.name;
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tempJump)];
    [view addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    _label = nil;
    if (view == nil)
    {
        view =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 450.0f, 450.0f)] ;
        view.backgroundColor = [UIColor blueColor];
        _label = [[UILabel alloc] initWithFrame:view.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [_label.font fontWithSize:50];
        _label.tag = 1;
        [view addSubview:_label];
        [self.view addSubview:view];
    }
    else
    {
        _label = (UILabel *)[view viewWithTag:1];
    }
    carousel.name = [NSString stringWithFormat:@"第%ld集",carousel.currentItemIndex];
    _label.text = [NSString stringWithFormat:@"%ld",(long)index];
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
            //设置没个界面直接的间隙，默认为0.25
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
