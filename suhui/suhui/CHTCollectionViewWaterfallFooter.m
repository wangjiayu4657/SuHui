//
//  CHTCollectionViewWaterfallFooter.m
//  Demo
//
//  Created by Neil Kimmett on 28/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallFooter.h"


@interface CHTCollectionViewWaterfallFooter()

@property (strong , nonatomic) UIView *preView;
@property (strong , nonatomic) UIView *sufView;
@property (strong , nonatomic) UIImageView *imageView;
@end

@implementation CHTCollectionViewWaterfallFooter

#pragma mark - Accessors
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor clearColor];
      
      _preView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/4 - 50, self.bounds.size.height/2, ScreenWidth/4, 1)];
      _preView.backgroundColor = [UIColor lightGrayColor];
      _preView.hidden = YES;
      [self addSubview:_preView];

      _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_preView.frame.size.width + _preView.frame.origin.x + 5, self.bounds.size.height / 2 - 10, 20, 20)];
      _imageView.layer.masksToBounds = YES;
      _imageView.layer.cornerRadius = 10;
      _imageView.backgroundColor = [UIColor redColor];
      _imageView.hidden = YES;
      [self addSubview:_imageView];
      
      _sufView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 2 + 50, self.bounds.size.height / 2, ScreenWidth / 4, 1)];
      _sufView.backgroundColor = [UIColor lightGrayColor];
      _sufView.hidden = YES;
      [self addSubview:_sufView];
      
      _footerContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.size.width + _imageView.frame.origin.x + 5, 0,ScreenWidth / 4 - 30, self.bounds.size.height)];
      _footerContentLabel.textAlignment = NSTextAlignmentLeft;
      _footerContentLabel.font = [UIFont systemFontOfSize:13];
      _footerContentLabel.textColor = [UIColor darkTextColor];
      _footerContentLabel.hidden = YES;
      [self addSubview:_footerContentLabel];
      
      
  }
  return self;
}

-(void)setFooterContentLabel:(UILabel *)footerContentLabel {
    _footerContentLabel = footerContentLabel;
}

-(void)setIsShow:(BOOL)isShow {
    _isShow = isShow;
    if (_isShow) {
        _preView.hidden = NO;
        _imageView.hidden = NO;
        _sufView.hidden = NO;
        _footerContentLabel.hidden = NO;
    }else {
        _preView.hidden = YES;
        _imageView.hidden = YES;
        _sufView.hidden = YES;
        _footerContentLabel.hidden = YES;
    }
    
}

@end
