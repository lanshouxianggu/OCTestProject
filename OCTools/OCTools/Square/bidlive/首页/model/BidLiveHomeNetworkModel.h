//
//  BidLiveHomeNetworkModel.h
//  OCTools
//
//  Created by bidlive on 2022/6/6.
//

#import <Foundation/Foundation.h>
#import "BidLiveHomeBannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BidLiveHomeNetworkModel : NSObject

///获取首页顶部banner列表
+(void)getHomePageBannerList:(NSInteger)bannerId client:(NSString *)client completion:(void (^)(NSArray<BidLiveHomeBannerModel *> *bannerList))completionBlock;

///获取首页动态列表
+(void)getHomePageArticleList:(int)pageIndex;
@end

NS_ASSUME_NONNULL_END
