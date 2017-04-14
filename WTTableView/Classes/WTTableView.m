//
//  WTTableView.m
//  Pods
//
//  Created by hongru qi on 2017/4/14.
//
//

#import "WTTableView.h"
#import "WTGenericModel.h"

@interface WTTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSourceProvider;

@end

@implementation WTTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)setDataProvider:(id<WTDataSourceProvider>)dataProvider
{
    _dataProvider = dataProvider;
    [self registerCells];
}

- (void)registerCells
{
    if ([self.dataProvider respondsToSelector:@selector(cellIdentifiers)]) {
        for (NSString *identifier in [self.dataProvider cellIdentifiers]) {
            [self registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
        }
    }
    
    if ([self.dataProvider respondsToSelector:@selector(xibCellIdentifiers)]) {
        for (NSString *identifer in [self.dataProvider xibCellIdentifiers]) {
            [self registerNib:[UINib nibWithNibName:identifer bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifer];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell <WTCellProtocol> *cell = nil;
    WTGenericModel *model = self.dataSourceProvider[indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:model.identifier forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(WTCellProtocol)]) {
        [cell loadData:model];
    }
    
}

@end
