//
//  SelectFirstView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/12/14.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SelectFirstViewDelegate <NSObject>

-(void)btnSelectWithTitle:(NSString *)title;

@end

@interface SelectFirstView : UIView
@property (nonatomic, strong) NSArray<NSString *> *selectTitleArray;
@property (nonatomic, weak) id<SelectFirstViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
