//
//  UIColor+LLRandomColor.m
//  BritishSocial2018
//
//  Created by liushong on 2018/12/18.
//  Copyright © 2018年 liushong. All rights reserved.
//

#import "UIColor+LLRandomColor.h"

@implementation UIColor (LLRandomColor)
+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
