//
//  ShareGroupTableViewCell.h
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareGroupTableViewCell : UITableViewCell
-(void)updateDataWithMode:(ShareGroupModel *)model;
@end

NS_ASSUME_NONNULL_END
