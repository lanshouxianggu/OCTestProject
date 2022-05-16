//
//  FileVerticalIndicatorView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FileVerticalIndicatorViewDelegate <NSObject>

-(void)indicatorViewMovedToPoint:(CGPoint)point andState:(UIGestureRecognizerState)state;

@end

@interface FileVerticalIndicatorView : UIView
@property (nonatomic, weak) id<FileVerticalIndicatorViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
