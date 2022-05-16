//
//  FileBaseReusableView.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/7.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "FileBaseReusableView.h"

@implementation FileBaseReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.dateLabelLeftLayout.constant = 12;
    self.selectImageV.hidden = YES;
}

-(void)setSelected:(BOOL)selected {
    _selected = selected;
    self.selectImageV.image = selected?[UIImage imageNamed:@"selected_icon"]:[UIImage imageNamed:@"unSelected_icon"];
}

-(IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.selected = sender.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(headViewSelect:andIndexPath:)]) {
        [self.delegate headViewSelect:sender.selected andIndexPath:self.currentIndexPath];
    }
}


@end
