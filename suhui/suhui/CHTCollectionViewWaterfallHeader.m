//
//  CHTCollectionViewWaterfallHeader.m
//  Demo
//
//  Created by Neil Kimmett on 21/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallHeader.h"

@implementation CHTCollectionViewWaterfallHeader

#pragma mark - Accessors
- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIColor whiteColor];
      
      _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, ScreenWidth - 30, 21)];
      _contentLabel.textAlignment = NSTextAlignmentLeft;
      _contentLabel.font = [UIFont systemFontOfSize:15];
      _contentLabel.textColor = [UIColor darkGrayColor];
      
      [self addSubview:_contentLabel];
      
  }
  return self;
}

-(void)setContentLabel:(UILabel *)contentLabel {
    _contentLabel = contentLabel;
    
}

-(void)setContentStr:(NSString *)contentStr {
    _contentStr = contentStr;
    _contentLabel.text = contentStr;
}

@end
