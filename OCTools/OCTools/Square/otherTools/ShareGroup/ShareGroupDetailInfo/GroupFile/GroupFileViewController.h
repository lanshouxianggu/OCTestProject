//
//  GroupFileViewController.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/4.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GroupFileViewControllerDelegate <NSObject>

-(void)selectCountChange:(NSInteger)selectCount;

@end

@interface GroupFileViewController : UIViewController
@property (nonatomic, assign) BOOL isAllSelect;
@property (nonatomic, assign) NSInteger selectCount;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) id<GroupFileViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
