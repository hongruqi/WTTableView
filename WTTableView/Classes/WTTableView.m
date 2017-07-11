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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceProvider.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell <WTCellProtocol> *cell = nil;
    WTGenericModel *model = self.dataSourceProvider[indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:model.identifier forIndexPath:indexPath];
    
    if ([cell conformsToProtocol:@protocol(WTCellProtocol)]) {
        [cell loadData:model];
    }
    
    if ([cell respondsToSelector:@selector(setCellDelegate:)]) {
        [cell setCellDelegate:self.cellDelegate];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= self.dataSourceProvider.count) {
        return 44;
    }
    
    WTGenericModel *model = self.dataSourceProvider[indexPath.row];
    if (model.cellHeight > 0) {
        return model.cellHeight;
    }
    
    Class cellClass = NSClassFromString(model.identifier);
    if ([cellClass respondsToSelector:@selector(cellHeight:)]) {
        return [cellClass cellHeight:model];
    }
    
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (self.dataSourceProvider.count > indexPath.row) {
        WTGenericModel *model = self.dataSource[indexPath.row];
        if (self.selectedBlock) {
            self.selectedBlock(model);
        }
    }
}

- (void)insertData:(WTGenericModel *)data atIndex:(NSInteger)index
{
    [self.dataSourceProvider insertObject:data atIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)deleteDataAtIndex:(NSInteger)index
{
    [self.dataSourceProvider removeObjectAtIndex:index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)refreshData
{
    [self reloadData];
}


@end
