//
//  CPISegementView.h
//  FORMUSIC
//
//  Created by yuehe on 2018/7/18.
//  Copyright © 2018年 云上钢琴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPISegementConfiguration : NSObject
@property (nonatomic, assign) CGFloat lineLeftOffset;
@property (nonatomic, assign) CGFloat lineRightOffset;
@property (nonatomic, assign) CGFloat lineBottomOffset;
@property (nonatomic, assign) CGFloat lineCornerRadius;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) UIColor *lineColor;

@property (nonatomic, assign) CGFloat btnSpacing;

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectColor;
@property (nonatomic, strong) UIFont *titleNormalFont;
@property (nonatomic, strong) UIFont *titleSelectFont;
@end

@interface CPISegementView : UIView

@property (nonatomic, copy) void (^selectBlock)(NSUInteger index);

- (instancetype)initWithFrame:(CGRect)frame titles:(nullable NSArray<NSString *> *)titles;
- (instancetype)initWithFrame:(CGRect)frame titles:(nullable NSArray<NSString *> *)titles config:(CPISegementConfiguration *)config;
- (void)setSelectIndex:(NSUInteger)index;

@end
