//
//  DiscoveryHeadSegmentView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/18.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DiscoveryHeadSegmentViewDelegate <NSObject>

-(void)didSelectItemAtIndex:(NSInteger)index;

@end

@interface DiscoveryHeadSegmentView : UIView

-(instancetype)initWithFrame:(CGRect)frame andItemTitles:(NSArray <NSString *>*)titlesArray;

-(void)needMoveScrollWithIndex:(NSInteger)index;

@property (nonatomic, weak) id<DiscoveryHeadSegmentViewDelegate> delegate;
-(void)updataUI:(NSArray *)dataArray;
@end

NS_ASSUME_NONNULL_END
