//
//  OTLBackClassView.h
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLBackClassView : UIView

@end

NS_ASSUME_NONNULL_END

@interface OTLBackClassTopCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@interface OTLBackClassBottomCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@end
