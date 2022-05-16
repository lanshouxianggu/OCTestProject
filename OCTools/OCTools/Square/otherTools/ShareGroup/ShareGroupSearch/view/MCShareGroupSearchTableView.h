//
//  MCShareGroupSearchTableView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCShareGroupSearchTableViewDelegate <NSObject>

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath ;

@end

@interface MCShareGroupSearchTableView : UIView
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, weak) id<MCShareGroupSearchTableViewDelegate> delegate;
@property (nonatomic, copy) NSString *searchKey;
@end

NS_ASSUME_NONNULL_END
