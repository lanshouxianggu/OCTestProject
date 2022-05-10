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

-(void)init {
    self.musicImageView.layer.cornerRadius = 6;
    self.audioView.layer.cornerRadius = 12;
    self.layer.cornerRadius = 9;
    self.layer.masksToBounds = YES;
    
    [self.audioPlayBtn setImage:[UIImage imageNamed:@"icon_play_task"] forState:UIControlStateNormal];
    [self.audioPlayBtn setImage:[UIImage imageNamed:@"icon_pause_task"] forState:UIControlStateSelected];
}

- (IBAction)playBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
