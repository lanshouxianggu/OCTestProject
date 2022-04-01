//
//  OTLPracticePianoCommonCellView.h
//  ChatClub
//
//  Created by stray s on 2022/3/31.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLPracticePianoCommonCellView : UIView
/// 初始化方法
-(instancetype)initWithFrame:(CGRect)frame
                   canExpand:(BOOL)canExpand
                    btnTitle:(NSString *)btnTitle
                    taskType:(PracticePianoTaskType)taskType;
/// 勾选事件block
@property (nonatomic, copy) void (^selectActionBlock)(BOOL isSelect);
@end

NS_ASSUME_NONNULL_END
