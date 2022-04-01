//
//  OTLPracticePianoTaskFirstCell.h
//  ChatClub
//
//  Created by stray s on 2022/3/31.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLPracticePianoTaskFirstCell : UITableViewCell
@property (nonatomic, copy) void (^updateConstraintBlock)(BOOL isSelectDecomposition, BOOL isSelectAllPractice, BOOL isSelectIntelligent);
@end

NS_ASSUME_NONNULL_END
