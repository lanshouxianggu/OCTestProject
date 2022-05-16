//
//  FileBaseFlowCell.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/7.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileBaseFlowCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImageV;
@property (nonatomic, assign) BOOL cellSelected;
@end

NS_ASSUME_NONNULL_END
