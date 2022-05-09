//
//  OTLAfterClassSheetPianoTaskCollectionCell.h
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLAfterClassSheetPianoTaskCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *partLabel;
@property (weak, nonatomic) IBOutlet UIView *audioView;

@property (nonatomic, copy) void (^deleteBlock)(void);

@end

NS_ASSUME_NONNULL_END
