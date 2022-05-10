//
//  OTLAddOrDeleteToolView.h
//  ChatClub
//
//  Created by stray s on 2022/3/31.
//  Copyright © 2022 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OTLAddOrDeleteToolView : UIView
@property (nonatomic, copy) void (^touchBlock)(NSString *currentStr);

-(instancetype)initWithFrame:(CGRect)frame currentNum:(int)currentNum;
-(void)updateValue:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
