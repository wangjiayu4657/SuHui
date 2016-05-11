//
//  ShopCell.m
//  suhui
//
//  Created by fangjs on 16/5/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "ShopCell.h"


@interface ShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ShopCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setShop:(SHShop *)shop {
    _shop = shop;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLabel.text = shop.price;
}

@end
