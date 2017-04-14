//
//  WTDataProvider.h
//  Pods
//
//  Created by hongru qi on 2017/4/14.
//
//

#import <Foundation/Foundation.h>
@class WTGenericModel;

@protocol WTDataSourceProvider <NSObject>

@optional
- (NSArray *)cellIdentifiers;
- (NSArray *)xibCellIdentifiers;
//获取需要处理的之后的数据，return nil 就用默认modelarray数据
- (NSMutableArray<WTGenericModel *> *)processedDataSource:(NSArray *)modelArray;

@end

@protocol WTCellProtocol <NSObject>

@optional

+ (CGFloat)cellHeight:(id)model;
//用于collectioncell
+ (CGSize)cellSize:(id)model collectionView:(UICollectionView *)collectionView;

- (void)setCellDelegate:(id)delegate;

@required

- (void)loadData:(id)data;

@end
