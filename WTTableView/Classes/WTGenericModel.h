//
//  WTGenericModel.h
//  Pods
//
//  Created by hongru qi on 2017/4/14.
//
//

#import <Foundation/Foundation.h>

@interface WTGenericModel : NSObject

@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) CGFloat cellHeight;

@end
