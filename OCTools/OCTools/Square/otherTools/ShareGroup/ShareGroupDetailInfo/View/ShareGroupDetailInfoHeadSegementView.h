//
//  ShareGroupDetailInfoHeadSegementView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ShareGroupDetailInfoHeadSegementViewDelegate <NSObject>

-(void)headViewSelectAtIndex:(int)index;

@end

@interface ShareGroupDetailInfoHeadSegementView : UIView
-(void)selectAtIndex:(int)index;

@property (nonatomic, weak) id<ShareGroupDetailInfoHeadSegementViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
