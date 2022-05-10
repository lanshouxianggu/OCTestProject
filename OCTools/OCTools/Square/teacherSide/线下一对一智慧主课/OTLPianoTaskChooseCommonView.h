//
//  OTLPianoTaskChooseCommonView.h
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TaskChooseTypePracticeDuration,
    TaskChooseTypePracticeDay,
    TaskChooseTypeSpeed,
} TaskChooseType;

NS_ASSUME_NONNULL_BEGIN

@interface OTLPianoTaskChooseCommonView : UIView
@property (nonatomic, copy) void (^selectBlock)(TaskChooseType type,NSString *selectStr);

-(void)showWithType:(TaskChooseType)type selectStr:(NSString *)selectStr;
-(void)dismiss;
@end

NS_ASSUME_NONNULL_END
