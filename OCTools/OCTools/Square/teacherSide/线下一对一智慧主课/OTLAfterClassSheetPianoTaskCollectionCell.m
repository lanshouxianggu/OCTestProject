//
//  OTLAfterClassSheetPianoTaskCollectionCell.m
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import "OTLAfterClassSheetPianoTaskCollectionCell.h"

@implementation OTLAfterClassSheetPianoTaskCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.layer.cornerRadius = 9;
    self.contentView.layer.masksToBounds = YES;
    
    self.audioView.layer.cornerRadius = 12;
    self.audioView.layer.masksToBounds = YES;
    
    [self.playBtn setImage:[UIImage imageNamed:@"icon_play_task"] forState:UIControlStateNormal];
    [self.playBtn setImage:[UIImage imageNamed:@"icon_pause_task"] forState:UIControlStateSelected];
}

- (IBAction)deleteAction:(id)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

- (IBAction)playBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

@end
