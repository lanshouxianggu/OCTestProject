//
//  OTLOfflineOneToOneSmartMajorBeforeClassLeftView.h
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLOfflineOneToOneSmartMajorBeforeClassLeftView : UIView
@property (nonatomic, copy) void (^selectBtnBlock)(NSInteger index);

-(void)selectIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
