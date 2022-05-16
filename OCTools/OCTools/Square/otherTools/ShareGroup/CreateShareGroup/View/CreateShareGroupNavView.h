//
//  CreateShareGroupNavView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CreateShareGroupNavViewDelegate <NSObject>

-(void)navViewCancelAction;
-(void)navViewSaveAction;

@end

@interface CreateShareGroupNavView : UIView
@property (nonatomic, weak) id<CreateShareGroupNavViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
