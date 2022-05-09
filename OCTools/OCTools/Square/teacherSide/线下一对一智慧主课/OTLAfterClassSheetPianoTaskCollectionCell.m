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
    
}

- (IBAction)deleteAction:(id)sender {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

@end
