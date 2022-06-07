//
//  BidLiveHomeScrollTopMainView.h
//  BidLiveIOSPlugin
//
//  Created by bidlive on 2022/5/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BidLiveHomeBannerModel;
@class BidLiveHomeCMSArticleModel;
@interface BidLiveHomeScrollTopMainView : UIView
///全球拍卖block
@property (nonatomic, copy) void (^globalSaleClickBlock)(void);
///国内拍卖block
@property (nonatomic, copy) void (^countrySaleClickBlock)(void);
///讲堂block
@property (nonatomic, copy) void (^speechClassClickBlock)(void);
///鉴定block
@property (nonatomic, copy) void (^appraisalClickBlock)(void);
///送拍block
@property (nonatomic, copy) void (^sendClickBlock)(void);
///资讯block
@property (nonatomic, copy) void (^informationClickBlock)(void);
///广告点击block
@property (nonatomic, copy) void (^bannerClick)(BidLiveHomeBannerModel *model);
///动态点击block
@property (nonatomic, copy) void (^cmsArticleClickBlock)(BidLiveHomeCMSArticleModel *model);

-(void)updateBanners:(NSArray<BidLiveHomeBannerModel *> *)banners;
-(void)updateCMSArticleList:(NSArray<BidLiveHomeCMSArticleModel *> *)list;
@end

NS_ASSUME_NONNULL_END
