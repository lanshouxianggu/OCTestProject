//
//  OTLPracticePianoTaskFirstPartView.h
//  OCTools
//
//  Created by stray s on 2022/5/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLPracticePianoTaskFirstPartView : UIView
@property (nonatomic, copy) void (^speedTouchBlock)(NSString *currentStr);

-(void)updateValue:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
