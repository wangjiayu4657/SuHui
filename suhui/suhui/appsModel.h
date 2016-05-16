//
//  appsModel.h
//  suhui
//
//  Created by fangjs on 16/5/16.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appsModel : NSObject

/**名称*/
@property (strong , nonatomic) NSString *name;

/**图片*/
@property (strong , nonatomic) NSString * icon;

/**下载量*/
@property (strong , nonatomic) NSString *download;

@end
