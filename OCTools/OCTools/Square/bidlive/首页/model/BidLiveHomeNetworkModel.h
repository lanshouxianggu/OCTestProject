//
//  BidLiveHomeNetworkModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/6.
//

#import <Foundation/Foundation.h>
#import "BidLiveHomeBannerModel.h"
#import "BidLiveHomeCMSArticleModel.h"
#import "BidLiveHomeGlobalLiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeNetworkModel : NSObject

///获取首页顶部banner列表
+(void)getHomePageBannerList:(NSInteger)bannerId client:(NSString *)client completion:(void (^)(NSArray<BidLiveHomeBannerModel *> *bannerList))completionBlock;

///获取首页动态列表
+(void)getHomePageArticleList:(int)pageIndex pageSize:(int)pageSize completion:(void (^)(NSArray<BidLiveHomeCMSArticleModel *> *cmsArticleList))completionBlock;

///获取首页全球直播列表
+(void)getHomePageGlobalLiveList:(NSString *)source completion:(void (^)(NSArray <BidLiveHomeGlobalLiveModel *> *liveList))completionBlock;
@end

NS_ASSUME_NONNULL_END
