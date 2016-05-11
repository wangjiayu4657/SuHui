//
//  HeaderView.m
//  suhui
//
//  Created by fangjs on 16/5/10.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "HeaderView.h"
#import "SDCycleScrollView.h"


#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HeaderView () <SDCycleScrollViewDelegate>
@property (strong, nonatomic)  SDCycleScrollView *bannerView;

@property (strong, nonatomic)  UIView *contentView;

/**button 数组*/
@property (strong , nonatomic)  NSMutableArray *btnArray;
@end

@implementation HeaderView

#pragma mark - Accessors
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor magentaColor];
    }
    return self;
}

-(NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

-(void)didMoveToSuperview {
//    self.edgesForExtendedLayout = UIRectEdgeNone;
     self.backgroundColor = [UIColor redColor];
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    
    
//    self.bannerView.imageURLStringsGroup = imagesURLStrings;
//    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    self.bannerView.delegate = self;
//    self.bannerView.titlesGroup = titles;
//    self.bannerView.currentPageDotColor = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
//    self.bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    
     self.bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100) delegate:nil placeholderImage:nil];
     self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
     self.bannerView.imageURLStringsGroup = imagesURLStrings;
     self.bannerView.titlesGroup = titles;
    [self addSubview:self.bannerView];
//    
//     self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 150)];
//     self.contentView.backgroundColor = [UIColor greenColor];
//    [self addSubview:self.contentView];
//    [self createButton];
    
}


#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
