//
//  HomeViewController.m
//  suhui
//
//  Created by fangjs on 16/5/10.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "HomeViewController.h"
#import "HeaderView.h"
#import "navigationCell.h"
#import "WaterFlowLayout.h"
#import "SHShop.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ShopCell.h"
#import "CustomShopCell.h"

#import "CHTCollectionViewWaterfallLayout.h"
#import "CHTCollectionViewWaterfallHeader.h"
#import "CHTCollectionViewWaterfallFooter.h"

#define HEADER_IDENTIFIER @"WaterfallHeader"
#define HEADER_IDENTIFIERVIEW @"WaterfallHeaderView"
#define FOOTER_IDENTIFIER @"WaterfallFooter"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height




@interface HomeViewController ()<UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *shops;


/**<#strong#>*/
@property (strong , nonatomic) CHTCollectionViewWaterfallLayout *flowLayout;

/**<#strong#>*/
@property (strong , nonatomic) NSMutableArray *contentArray;

@end

@implementation HomeViewController

-(NSMutableArray *)shops{
    if (!_shops) {
        _shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLayout];
    [self loadDataSource];
    

    
    self.contentArray = [NSMutableArray arrayWithObjects:@"精品分类",@"热卖商品", nil];
}

- (void) loadDataSource {
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    NSMutableArray *array3 = [NSMutableArray array];
    NSMutableArray *array4 = [NSMutableArray array];
    
    NSArray *array = [SHShop objectArrayWithFilename:@"1.plist"];
//    NSLog(@"%@",array);
    for (NSInteger i = 0; i < array.count; i++) {
        if (i < 6) {
            [array1 addObject:array[i]];
        }
        else if (i >= 6 && i < 9) {
            [array2 addObject:array[i]];
        }
        else if (i >= 9 && i < 14) {
            [array3 addObject:array[i]];
        }
        else {
            [array4 addObject:array[i]];
        }
    }
    [self.shops removeAllObjects];
    
    [self.shops addObject:array1];
    [self.shops addObject:array2];
    [self.shops addObject:array3];
    [self.shops addObject:array4];
    /**刷新数据*/
    [self.collectionView reloadData];

}

- (void)setUpLayout {
    self.flowLayout = [[CHTCollectionViewWaterfallLayout alloc] init];
    self.flowLayout.minimumColumnSpacing = 5;
    self.flowLayout.minimumInteritemSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.800 alpha:1.000];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
   
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([navigationCell class]) bundle:nil] forCellWithReuseIdentifier:navigationCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ShopCell class]) bundle:nil] forCellWithReuseIdentifier:shopCellID];
    
    [self.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:HEADER_IDENTIFIERVIEW];
    [self.collectionView registerClass:[CHTCollectionViewWaterfallHeader class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:HEADER_IDENTIFIER];
    [self.collectionView registerClass:[CHTCollectionViewWaterfallFooter class] forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter withReuseIdentifier:FOOTER_IDENTIFIER];
    
    [self.view addSubview: self.collectionView];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *array = self.shops[section];
    return array.count;
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.shops.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//         self.flowLayout.itemRenderDirection = CHTCollectionViewWaterfallLayoutItemRenderDirectionShortestFirst;
         navigationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:navigationCellID forIndexPath:indexPath];
         cell.shop = self.shops[indexPath.section][indexPath.item];
         return cell;
    }
    else {
//        self.flowLayout.itemRenderDirection = CHTCollectionViewWaterfallLayoutItemRenderDirectionLeftToRight;
        ShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:shopCellID forIndexPath:indexPath];
        cell.shop = self.shops[indexPath.section][indexPath.item];
         return cell;
    }
   
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    if (indexPath.section == 0) {
        if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                              withReuseIdentifier:HEADER_IDENTIFIERVIEW
                                                                     forIndexPath:indexPath];
        }
        else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                              withReuseIdentifier:FOOTER_IDENTIFIER
                                                                     forIndexPath:indexPath];
            CHTCollectionViewWaterfallFooter *footerView = (CHTCollectionViewWaterfallFooter *)reusableView;
            footerView.isShow = NO;
        }
        

    }else  {
        if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                              withReuseIdentifier:HEADER_IDENTIFIER
                                                                     forIndexPath:indexPath];
            CHTCollectionViewWaterfallHeader *headerView = (CHTCollectionViewWaterfallHeader *) reusableView;
            if (indexPath.section == 1) {
                 headerView.contentLabel.text = @"精品分类";
            }
            if (indexPath.section == 2) {
                 headerView.contentLabel.text = @"热卖商品";
            }
        }
        else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
            reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                              withReuseIdentifier:FOOTER_IDENTIFIER
                                                                     forIndexPath:indexPath];
            CHTCollectionViewWaterfallFooter *footerView = (CHTCollectionViewWaterfallFooter *)reusableView;
            if (indexPath.section == 2) {
                footerView.isShow = YES;
            }
            else {
                footerView.isShow = NO;
            }
        }
    }
     return reusableView;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld   %ld",indexPath.section,indexPath.item);
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(86, 86);
    }
    else if (indexPath.section == 1){
        if (indexPath.item == 0) {
            return CGSizeMake(158, 200);
        }else {
            return CGSizeMake(162, 100);
        }
    }
    else if (indexPath.section == 2) {
        
        if (indexPath.item == 0) {
            return CGSizeMake(59 , 100);
        }else {
            return CGSizeMake(121, 100);
        }
    }
    else {
        return CGSizeMake(162, 200);
    }
}


- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 100;
    }
    else if (section > 0 && section < 3) {
        return 30;
    }
    else {
        return 0;
    }
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    else if (section == 2) {
        return 3;
    }
    else  {
        return 2;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    searchBar.backgroundColor = [UIColor redColor];
//
//    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//    self.searchController.delegate = self;

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
