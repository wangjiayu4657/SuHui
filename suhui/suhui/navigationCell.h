//
//  navigationCell.h
//  suhui
//
//  Created by fangjs on 16/5/10.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *const cellID = @"itemCell";

@interface navigationCell : UICollectionViewCell

/**模型*/
@property (strong , nonatomic) SHShop *shop;

@end
