//
//  OTLAfterClassSheetVideoCell.h
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLAfterClassSheetVideoCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *videosArr;
@property (nonatomic, copy) void (^videoAddBlock)(void);
@property (nonatomic, copy) void (^videoDeleteBlock)(NSInteger index);
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
