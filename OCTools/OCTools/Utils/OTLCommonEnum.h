//
//  OTLCommonEnum.h
//  CarodOnlineTeaching
//
//  Created by stray s on 2022/1/14.
//  Copyright © 2022 YueHe. All rights reserved.
//

#ifndef OTLCommonEnum_h
#define OTLCommonEnum_h

#pragma mark - AI练琴房内自定义信息类型
///AI练琴房内自定义信息类型
typedef enum : NSUInteger {
    AIRoomMessageTipsTypeHandsUp=0, ///举手提问
    AIRoomMessageTipsTypeJoinClass, ///加入房间
    AIRoomMessageTipsTypeQuitClass, ///退出房间
    AIRoomMessageTipsTypeNoPlayTime,///未练琴
    AIRoomMessageTipsTypePractice,  ///练琴动作
    AIRoomMessageTipsTypeWarn,      ///预警互动
    AIRoomMessageTipsTypeEncourage, ///鼓励互动
} AIRoomMessageTipsType;

#pragma mark - 查看数据类型
///查看数据类型
typedef enum : NSUInteger {
    checkReportTypeDecompostion=0,  ///分解练习报告
    checkReportTypeWhole,           ///全曲练习报告
    checkReportTypeIntelligent,     ///智能测评报告
} checkReportType;

#pragma mark - 练琴类型
///练琴类型
typedef enum : NSUInteger {
    ///分解练习
    PracticePianoTypeDecompostion=0,
    ///全曲练习
    PracticePianoTypeWhole,
    ///智能测评
    PracticePianoTypeIntelligent,
} PracticePianoType;

#pragma mark - 练琴任务
typedef enum : NSUInteger {
    ///速度要求
    PracticePianoTaskTypeSpeed=0,
    ///分解练习
    PracticePianoTaskTypeDecompostion,
    ///全曲练习
    PracticePianoTaskTypeWhole,
    ///智能测评
    PracticePianoTaskTypeIntelligent,
} PracticePianoTaskType;

#endif /* OTLCommonEnum_h */
