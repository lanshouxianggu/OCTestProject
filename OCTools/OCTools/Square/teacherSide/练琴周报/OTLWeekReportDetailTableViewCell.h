//
//  OTLWeekReportDetailTableViewCell.h
//  TeacherSide
//
//  Created by stray s on 2022/3/2.
//  Copyright © 2022 YueHe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLWeekReportDetailTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL hasPractice;//是否练琴学员
-(void)updateWithDataDic:(NSDictionary *)dic;
@end

@interface OTLWeekReportPracticeDetailInfoView : UIView
-(instancetype)initWithFrame:(CGRect)frame hasPractice:(BOOL)hasPractice;
-(void)updateWithDataDic:(NSDictionary *)dic;
@end

typedef enum : NSUInteger {
    PracticeTypeDays,//练琴天数
    PracticeTypeDuration,//练琴时长
} PracticeType;
@interface OTLWeekReportPracticeDetailInfoSubView : UIView
-(instancetype)initWithFrame:(CGRect)frame type:(PracticeType)type;
-(void)updateWithDataDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
