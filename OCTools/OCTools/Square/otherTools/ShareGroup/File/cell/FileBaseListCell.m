//
//  FileBaseListCell.m
//  ChatClub
//
//  Created by ArcherMind on 2020/8/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "FileBaseListCell.h"

@implementation FileBaseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(listCellSelectAction:andIndexPath:)]) {
        [self.delegate listCellSelectAction:sender.selected andIndexPath:self.indexPath];
    }
}

@end
