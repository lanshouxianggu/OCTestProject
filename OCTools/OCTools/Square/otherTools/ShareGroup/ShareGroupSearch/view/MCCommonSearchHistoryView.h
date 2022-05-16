//
//  MCCommonSearchHistoryView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCCommonSearchHistoryViewDelegate <NSObject>

-(void)didSelectSearchItemWithSearchKey:(NSString *)searchKey;

@end

@interface MCCommonSearchHistoryView : UIView
@property (nonatomic, strong) UIView *clearHistoryView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, weak) id<MCCommonSearchHistoryViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
