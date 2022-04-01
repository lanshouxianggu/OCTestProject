//
//  UIImage+Tool.h
//  ItheimaLottery
//
//  Created by apple on 14/11/8.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tool)

/**
 图片方向旋转

 @return 
 */
- (UIImage *)fixOrientation;

//根据屏幕宽来裁剪图片
- (UIImage *)scaleToScreenSize;

- (NSData *)compressedData;
/**
 *  不要渲染图片
 */
+ (UIImage *)imageOriginalName:(NSString *)imageName;

/**
 *  拉伸图片
 */
+ (UIImage *)imageResizable:(UIImage *)image;

/**
 *  把图片改成圆形并且可以加边框
 */
+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;


//图片压缩到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

//截取部分图像
-(UIImage*)getSubImage:(CGRect)rect;

// 按照fram 来裁剪图片
//- (UIImage *)croppedImage:(CGRect)frame;

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

//黑白处理
- (UIImage *)noir;

/**
 *  图片压缩
 *
 *  @param sourceImg   被压缩的图片
 *  @param defineWidth 被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+(UIImage *)imageCompressed:(UIImage *)sourceImage withdefineWidth:(CGFloat)defineWidth ;

- (UIImage *)otlImageWithTintColor:(UIColor *)tintColor;

- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

+ (UIImage *)convertViewToImage:(UIView *)tempView;

/*
 屏幕截图
 */
+ (UIImage *)imageByCaptureScreen;

+ (UIImage *)imageByCaptureScreenTop:(CGFloat)top bottom:(CGFloat)bottom;

+ (UIImage *)studentImgByCaptureScreen;

+ (UIImage*)createImageWithColor: (UIColor*) color;

// 把颜色转变成为相应尺寸的图片
+ (UIImage *)createImageWithColor:(UIColor *)color rangeSize:(CGSize)size;

+ (UIImage *)randomBlockImage:(CGFloat )witdh  h:(CGFloat )height x:(CGFloat )x y:(CGFloat )y image:(UIImage *)image;

+ (UIImage *)compressImageWith:(UIImage *)image;

@end
