//
//  FileBaseListCell.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FileBaseListCellDelegate <NSObject>

-(void)listCellSelectAction:(BOOL)select andIndexPath:(NSIndexPath *)indexPath;

@end

@interface FileBaseListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<FileBaseListCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
