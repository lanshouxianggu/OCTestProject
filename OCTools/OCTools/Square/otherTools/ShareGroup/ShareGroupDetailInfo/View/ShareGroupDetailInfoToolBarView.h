//
//  ShareGroupDetailInfoToolBarView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/5.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ShareGroupFileOperateTypeDownload,  //下载
    ShareGroupFileOperateTypeSave,      //转存云盘
    ShareGroupFileOperateTypeMove,      //移动
    ShareGroupFileOperateTypeDelete,    //删除
    ShareGroupFileOperateTypeMore,      //更多
} ShareGroupFileOperateType;

@protocol ShareGroupDetailInfoToolBarViewDelegate <NSObject>

-(void)didSelectIndexWithOperateType:(ShareGroupFileOperateType)operateType;

@end

@interface ShareGroupDetailInfoToolBarView : UIView
@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic, weak) id<ShareGroupDetailInfoToolBarViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
