//
//  OTLStudentSidePracticePianoTaskMainView.h
//  OCTools
//
//  Created by stray s on 2022/5/10.
//

#import <UIKit/UIKit.h>
#import "OTLStudentSidePracticePianoTaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OTLStudentSidePracticePianoTaskMainView : UIView
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UIView *practicePianoMainView;
@property (weak, nonatomic) IBOutlet UIView *audioView;
@property (weak, nonatomic) IBOutlet UIButton *audioPlayBtn;
@property (weak, nonatomic) IBOutlet UILabel *audioDurationLabel;

///速度要求垂直居中偏移的layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *speedLabelCenterYLayout;
///任务要求垂直居中偏移的layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taskLabelCenterYLayout;
///练琴要求垂直居中偏移的layout
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *practicePianoMainViewCenterYLayout;

@property (nonatomic, strong) OTLStudentSidePracticePianoTaskListModel *listModel;

+(instancetype)customerView;
-(void)initData;
@end

NS_ASSUME_NONNULL_END
