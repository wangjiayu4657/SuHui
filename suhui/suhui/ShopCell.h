//
//  ShopCell.h
//  suhui
//
//  Created by fangjs on 16/5/11.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>



static NSString * const shopCellID = @"shopCellID";

@interface ShopCell : UICollectionViewCell

/**商品模型*/
@property (strong , nonatomic)  SHShop *shop;

@end
