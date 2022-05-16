//
//  FileBaseFlowCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/7.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "FileBaseFlowCell.h"

@implementation FileBaseFlowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectImageV.hidden = YES;
    self.cellSelected = NO;
}

-(void)setCellSelected:(BOOL)cellSelected {
    _cellSelected = cellSelected;
    self.selectImageV.image = cellSelected?[UIImage imageNamed:@"selected_icon"]:[UIImage imageNamed:@"unSelected_icon"];
}

@end
