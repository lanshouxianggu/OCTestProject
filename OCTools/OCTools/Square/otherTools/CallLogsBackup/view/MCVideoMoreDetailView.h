//
//  MCVideoMoreDetailView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/11/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCVideoMoreDetailViewDelegate <NSObject>

-(void)videoMoreDetailViewDeleteAction;//删除
-(void)videoMoreDetailViewDownloadAction;//下载
-(void)videoMoreDetailViewArticulationAction;//清晰度
-(void)videoMoreDetailViewSpeedPlayAction;//倍速播放
-(void)videoMoreDetailViewDetailInfoAction;//详细信息


@end

@interface MCVideoMoreDetailView : UIView
@property (nonatomic, weak) id<MCVideoMoreDetailViewDelegate> delegate;
@end

@interface MCVideoMoreDetailViewCell : UICollectionViewCell
@property (nonatomic, strong) NSDictionary *dataDic;
@end

NS_ASSUME_NONNULL_END
