//
//  OTLAfterClassSheetPianoTaskCell.h
//  OCTools
//
//  Created by stray s on 2022/5/7.
//

#import <UIKit/UIKit.h>
#import "OTLPianoTaskChooseCommonView.h"


NS_ASSUME_NONNULL_BEGIN

@interface OTLAfterClassSheetPianoTaskNormalView : UIView
-(instancetype)initWithLeftTitle:(NSString *)leftTitle;
-(void)updateRightValue:(NSString *)value;
@property (nonatomic, copy) void (^rightActionBlock)(NSString *currentStr);
@end

@interface OTLAfterClassSheetPianoTaskCell : UITableViewCell
///练琴时长view
@property (nonatomic, strong) OTLAfterClassSheetPianoTaskNormalView *practiceDurationView;
///练琴天数view
@property (nonatomic, strong) OTLAfterClassSheetPianoTaskNormalView *practiceDaysView;

@property (nonatomic, copy) void (^tasksUpdateBlock)(void);
@property (nonatomic, copy) void (^rightActionBlock)(TaskChooseType type, NSString *currentStr);
@property (nonatomic, strong) NSMutableArray *tasksArray;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
