//
//  BidLiveHomeFirstTableViewCell.h
//  LiveFloatPlugin
//
//  Created by bidlive on 2022/5/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeFirstTableViewCell : UITableViewCell
///全球拍卖block
@property (nonatomic, copy) void (^globalSaleClickBlock)(void);
///国内拍卖block
@property (nonatomic, copy) void (^countrySaleClickBlock)(void);
///讲堂block
@property (nonatomic, copy) void (^speechClassClickBlock)(void);
///鉴定block
@property (nonatomic, copy) void (^appraisalClickBlock)(void);
///送拍block
@property (nonatomic, copy) void (^sendClickBlock)(void);
///资讯block
@property (nonatomic, copy) void (^informationClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
