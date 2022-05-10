//
//  OTLStudentSidePracticePianoTaskModel.h
//  OCTools
//
//  Created by stray s on 2022/5/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLStudentSidePracticePianoTaskListModel : NSObject
///练琴曲目编号
@property (nonatomic, assign) NSInteger number;
///练琴曲目名称
@property (nonatomic, copy) NSString *musicName;
///已练习时长
@property (nonatomic, assign) NSInteger alreadyPracticeTime;
///曲目封面
@property (nonatomic, copy) NSString *musicPicUrl;
///速度要求
@property (nonatomic, assign) NSInteger speed;
///任务要求
@property (nonatomic, copy) NSString *taskPart;
///练琴要求
@property (nonatomic, copy) NSString *audioPath;
@end

@interface OTLStudentSidePracticePianoTaskModel : NSObject
///练琴周期日期
@property (nonatomic, copy) NSString *taskDateTime;
///总的已练琴时长
@property (nonatomic, assign) CGFloat totalAlreadyTime;
///总的应练琴时长
@property (nonatomic, assign) CGFloat totalNeedTime;
///曲目详情列表
@property (nonatomic, strong) NSArray <OTLStudentSidePracticePianoTaskListModel*> *listModel;
@end

NS_ASSUME_NONNULL_END
