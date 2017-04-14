//
//  WTTableView.h
//  Pods
//
//  Created by hongru qi on 2017/4/14.
//
//

#import <UIKit/UIKit.h>
#import "WTDataProvider.h"

@interface WTTableView : UITableView

@property (nonatomic, strong, readonly) NSMutableArray *dataSourceProvider;
@property (nonatomic, weak) id<WTDataSourceProvider> dataProvider;

- (void)refreshData;

@end
