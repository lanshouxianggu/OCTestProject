//
//  MCCommonSearchTitleCell.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCCommonSearchTitleCellDelegate <NSObject>

-(void)didClickDeleteAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MCCommonSearchTitleCell : UICollectionViewCell
@property (nonatomic,strong) UIView * setView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) id<MCCommonSearchTitleCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
