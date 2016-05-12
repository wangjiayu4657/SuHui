//
//  navigationCell.m
//  suhui
//
//  Created by fangjs on 16/5/10.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "navigationCell.h"

@interface navigationCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end


@implementation navigationCell

- (void)awakeFromNib {
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 25.0;
    self.imageView.center = self.center;
}


-(void) setShop:(SHShop *) shop {
    _shop = shop;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"chatBar_colorMore_audioCallSelected"]];
    
     self.contentLabel.text = shop.price;
}

@end
