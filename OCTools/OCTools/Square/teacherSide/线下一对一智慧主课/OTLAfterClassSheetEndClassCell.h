//
//  OTLAfterClassSheetEndClassCell.h
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLAfterClassSheetEndClassCell : UITableViewCell
@property (nonatomic, copy) void (^endClassBlock)(void);
@end

NS_ASSUME_NONNULL_END
