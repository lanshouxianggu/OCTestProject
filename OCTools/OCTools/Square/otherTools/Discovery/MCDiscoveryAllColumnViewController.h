//
//  MCDiscoveryAllColumnViewController.h
//  ChatClub
//
//  Created by 刘创 on 2021/7/16.
//  Copyright © 2021 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCDiscoveryAllColumnViewControllerDelegate <NSObject>

-(void)didClickItemAtIndex:(NSInteger)index;
-(void)updateDataArrayAfterMove:(NSArray *)dataArray currentIndex:(NSInteger)currentIndex;

@end

@interface MCDiscoveryAllColumnViewController : UIViewController
@property (nonatomic, weak) id<MCDiscoveryAllColumnViewControllerDelegate> delegate;

-(instancetype)initWithTitleArray:(NSArray *)titlesArray currentSelectIndex:(NSInteger)currentSelectInde;
@end

NS_ASSUME_NONNULL_END
