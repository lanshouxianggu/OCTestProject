//
//  OTLAfterClassSheetPianoTaskCell.h
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLAfterClassSheetPianoTaskCell : UITableViewCell
@property (nonatomic, strong) NSArray *tasksArray;
@end

NS_ASSUME_NONNULL_END

@interface OTLAfterClassSheetPianoTaskNormalView : UIView
-(instancetype)initWithLeftTitle:(NSString *)leftTitle;
-(void)updateRightValue:(NSString *)value;
@property (nonatomic, copy) void (^rightActionBlock)(void);
@end
