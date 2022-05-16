//
//  MCCommonSearchTitleModel.m
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import "MCCommonSearchTitleModel.h"

@implementation MCCommonSearchTitleModel

-(void)setDisplayTitle:(NSString *)displayTitle {
    _displayTitle = displayTitle;
    CGFloat width = [self calculateStrwidthWithStr:displayTitle Font:[UIFont systemFontOfSize:15]];
    self.titleRect = CGSizeMake(width+40, 40);
}

- (float)calculateStrwidthWithStr:(NSString *)str Font: (UIFont *) font
{
//    if (str.length > 8) {
//        str = [str substringToIndex:8];
//    }
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, font.pointSize)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil];
    if (str.length == 1) {
        return ceilf(textRect.size.width+20);
    }
    return ceil(textRect.size.width);
}
@end
