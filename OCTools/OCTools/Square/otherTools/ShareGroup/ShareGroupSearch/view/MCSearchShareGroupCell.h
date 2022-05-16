//
//  MCSearchShareGroupCell.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSearchShareGroupModel.h"
#import "MCSearchGroupFileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MCSearchShareGroupCell : UITableViewCell
@property (nonatomic, strong) MCSearchShareGroupModel *groupModel;
@property (nonatomic, strong) MCSearchGroupFileModel *fileModel;
@end

NS_ASSUME_NONNULL_END
