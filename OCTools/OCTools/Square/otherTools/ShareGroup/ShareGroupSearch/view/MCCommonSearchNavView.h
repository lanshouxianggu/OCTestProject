//
//  MCCommonSearchNavView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/21.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCCommonSearchNavViewDelegate <NSObject>

-(void)didClickCancel;
-(void)didSearch:(NSString *)searchKey;
-(void)searchContentDidClear;
@end

@interface MCCommonSearchNavView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<MCCommonSearchNavViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
