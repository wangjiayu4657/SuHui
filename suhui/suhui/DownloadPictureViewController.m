//
//  DownloadPictureViewController.m
//  suhui
//
//  Created by fangjs on 16/5/16.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "DownloadPictureViewController.h"
#import "appsModel.h"

@interface DownloadPictureViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**数据源*/
@property (strong , nonatomic)  NSMutableArray *dataSource;

/**缓存图片*/
@property (strong , nonatomic)  NSMutableDictionary *imagesDict;

/**缓存操作*/
@property (strong , nonatomic)  NSMutableDictionary * operations;

/**队列*/
@property (strong , nonatomic)  NSOperationQueue *queue;

@end

@implementation DownloadPictureViewController

-(NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        //设置最大并发数
        _queue.maxConcurrentOperationCount = 3;
    }
    return _queue;
}

-(NSMutableDictionary *)imagesDict{
    if (!_imagesDict) {
        _imagesDict = [NSMutableDictionary dictionary];
    }
    return _imagesDict;
}

-(NSMutableDictionary *)operations{
    if (!_operations) {
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *dic in arr) {
            appsModel *shop = [[appsModel alloc] init];
            [shop setValuesForKeysWithDictionary:dic];
            [_dataSource addObject:shop];
        }
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"shops";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    appsModel *model = self.dataSource[indexPath.row];
    
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.download;
    
    UIImage *image = self.imagesDict[model.icon];
    if (image) {
        cell.imageView.image = image;
    }else {
        // 获得Library/Caches文件夹
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        // 获取文件名
        NSString *fileName = [model.icon lastPathComponent];
        // 拼接全路径
        NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];

        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        if (data) {
            UIImage *image = [UIImage imageWithData:data];
            cell.imageView.image = image;
            self.imagesDict[model.icon] = image;
        }
        else {
            cell.imageView.image = [UIImage imageNamed:@"loading"];
         
            NSOperation *operation = self.operations[model.icon];
            if (operation == nil) {
                        operation = [NSBlockOperation blockOperationWithBlock:^{
                        //下载图片
                        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.icon]];
                            //如果下载失败
                            if (data == nil) {
                                //清除操作
                                [self.operations removeObjectForKey:model.icon];
                                return ;
                            }
                            
                        UIImage *image = [UIImage imageWithData:data];
                        //将下载的图片放进内存中
                        self.imagesDict[model.icon] = image;
                        
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //刷新某一行
                            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
                        }];
                        
                        //将下载的图片放进沙河中
                        [data writeToFile:filePath atomically:YES];
                        //移除操作
                        [self.operations removeObjectForKey:model.icon];
                    }];
                 //添加到队列中
                 [self.queue addOperation:operation];
                 //存放到字典中
                  self.operations[model.icon] = operation;
            }
        }
     }

    return cell;
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
