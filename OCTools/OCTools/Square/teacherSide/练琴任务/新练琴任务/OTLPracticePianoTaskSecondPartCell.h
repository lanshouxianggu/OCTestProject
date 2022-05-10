//
//  OTLPracticePianoTaskSecondPartCell.h
//  OCTools
//
//  Created by stray s on 2022/5/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLPracticePianoTaskSecondPartCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIImageView *partImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectImage;
@end

NS_ASSUME_NONNULL_END
