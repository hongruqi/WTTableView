//
//  WTTableView.h
//  Pods
//
//  Created by hongru qi on 2017/4/14.
//
//

#import <UIKit/UIKit.h>
#import "WTDataProvider.h"

@class WTGenericModel;

typedef void(^didSelectedBlock)(WTGenericModel *model);

@interface WTTableView : UITableView

@property (nonatomic, strong, readonly) NSMutableArray *dataSourceProvider;
@property (nonatomic, weak) id<WTDataSourceProvider> dataProvider;
@property (nonatomic, weak) id cellDelegate;
@property (nonatomic, copy) didSelectedBlock selectedBlock;

- (void)refreshData;

@end
