//
//  TipProgress.h
//  ZhongdaBoyan
//
//  Created by JIMU on 15/4/9.
//  Copyright (c) 2015年 jimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

typedef enum{
    NSTipProgressTypeCenter = 0,
    NSTipProgressTypeTop,
    NSTipProgressTypeBottom
} NSTipProgressType;

NS_ASSUME_NONNULL_BEGIN

@interface TipProgress : UIView
singleton_interface(TipProgress);
@property (nonatomic, retain) NSString *showstring;
@property (nonatomic, readwrite) NSTipProgressType type;
+(void)showText:(NSString *)str type:(NSTipProgressType)type;
+(void)showText:(NSString *)str;
+(void)showText:(NSString *)str delay:(NSTimeInterval)delay completion:(void (^ __nullable)(BOOL finished))completion;
@end

NS_ASSUME_NONNULL_END
