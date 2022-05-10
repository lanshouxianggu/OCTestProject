//
//  OTLStudentSidePracticePianoTaskMainView.m
//  OCTools
//
//  Created by stray s on 2022/5/10.
//

#import "OTLStudentSidePracticePianoTaskMainView.h"

@interface OTLStudentSidePracticePianoTaskMainView ()
///是否有速度要求
@property (nonatomic, assign) BOOL hasSpeed;
///是否有任务要求
@property (nonatomic, assign) BOOL hasTask;
///是否有练琴要求
@property (nonatomic, assign) BOOL hasPracticePiano;
@end

@implementation OTLStudentSidePracticePianoTaskMainView

+(instancetype)customerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"OTLStudentSidePracticePianoTaskMainView" owner:self options:nil] firstObject];
}

-(void)initData {
    self.musicImageView.layer.cornerRadius = 6;
    self.audioView.layer.cornerRadius = 12;
    self.layer.cornerRadius = 9;
    self.layer.masksToBounds = YES;
    
    [self.audioPlayBtn setImage:[UIImage imageNamed:@"icon_play_task"] forState:UIControlStateNormal];
    [self.audioPlayBtn setImage:[UIImage imageNamed:@"icon_pause_task"] forState:UIControlStateSelected];
}

-(void)setListModel:(OTLStudentSidePracticePianoTaskListModel *)listModel {
    _listModel = listModel;
    self.nameLabel.attributedText = [NSAttributedString makeAttributedString:^(LLAttributedStringMaker * _Nonnull make) {
        make.text([NSString stringWithFormat:@"%02ld ",listModel.number]).foregroundColor(OTLAppMainColor).font([UIFont systemFontOfSize:20]);
        make.text(listModel.musicName);
    }];
    if (listModel.alreadyPracticeTime>0) {
        self.durationLabel.text = [NSString stringWithFormat:@"已练习%ld分钟",listModel.alreadyPracticeTime];
    }else {
        self.durationLabel.text = @"未练习";
    }
    
    if (listModel.speed>0 && listModel.taskPart.length && listModel.audioPath.length) {
        //速度要求、任务要求、练琴要求
        self.speedLabel.hidden = NO;
        self.taskLabel.hidden = NO;
        self.practicePianoMainView.hidden = NO;
        
        self.taskLabelCenterYLayout.constant = 0;
        self.speedLabelCenterYLayout.constant = -30;
        self.practicePianoMainViewCenterYLayout.constant = 30;
    }else if (listModel.taskPart.length && listModel.speed==0 && listModel.audioPath.length) {
        //任务要求、练琴要求
        self.speedLabel.hidden = YES;
        self.taskLabel.hidden = NO;
        self.practicePianoMainView.hidden = NO;
        
        self.taskLabelCenterYLayout.constant = -15;
        self.practicePianoMainViewCenterYLayout.constant = 15;
    }else if (listModel.taskPart.length && listModel.speed>0 && listModel.audioPath.length==0) {
        //任务要求、速度要求
        self.speedLabel.hidden = NO;
        self.taskLabel.hidden = NO;
        self.practicePianoMainView.hidden = YES;
        
        self.taskLabelCenterYLayout.constant = 15;
        self.speedLabelCenterYLayout.constant = -15;
    }else if (listModel.taskPart.length && listModel.speed==0 && listModel.audioPath.length==0) {
        //任务要求
        self.speedLabel.hidden = YES;
        self.practicePianoMainView.hidden = YES;
        self.taskLabel.hidden = NO;
        
        self.taskLabelCenterYLayout.constant = 0;
    }
}

#pragma mark - 播放事件
- (IBAction)playBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
