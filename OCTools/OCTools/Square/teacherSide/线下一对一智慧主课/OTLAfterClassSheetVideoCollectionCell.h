//
//  OTLAfterClassSheetVideoCollectionCell.h
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLAfterClassSheetVideoCollectionCell : UICollectionViewCell
@property (nonatomic, copy) void(^deleteBlock)(void);
@end

NS_ASSUME_NONNULL_END
