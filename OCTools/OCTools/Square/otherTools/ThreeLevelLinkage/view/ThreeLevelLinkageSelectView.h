//
//  ThreeLevelLinkageSelectView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/12/14.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ThreeLevelLinkageSelectViewDelegate <NSObject>

-(void)resetAction;
-(void)completeActionWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end

@interface ThreeLevelLinkageSelectView : UIView
@property (nonatomic, weak) id<ThreeLevelLinkageSelectViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
