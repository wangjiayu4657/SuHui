//
//  CHTCollectionViewWaterfallHeader.h
//  Demo
//
//  Created by Neil Kimmett on 21/10/2013.
//  Copyright (c) 2013 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHTCollectionViewWaterfallHeader : UICollectionReusableView
/**contentLabel*/
@property (strong , nonatomic) UILabel *contentLabel;

/**内容*/
@property (strong , nonatomic)  NSString *contentStr;
@end
