//
//  OTLOfflineOneToOneSmartMajorBeforeClassRightView.h
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLOfflineOneToOneSmartMajorBeforeClassRightView : UIView
@property (nonatomic, copy) void (^scrollToIndexBlock)(int index);

-(void)scrollToIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
