//
//  FileBaseReusableView.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/7.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FileBaseReusableViewDelegate <NSObject>

-(void)headViewSelect:(BOOL)select andIndexPath:(NSIndexPath *)indexPath;

@end

@interface FileBaseReusableView : UICollectionReusableView
@property (nonatomic, weak) IBOutlet UIImageView *selectImageV;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIButton *selectBtn;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *dateLabelLeftLayout;
@property (nonatomic, strong) NSIndexPath *currentIndexPath;
@property (nonatomic, assign) BOOL selected;

@property (nonatomic, weak) id<FileBaseReusableViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
