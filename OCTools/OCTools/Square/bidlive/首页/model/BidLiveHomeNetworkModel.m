//
//  BidLiveHomeNetworkModel.m
//  OCTools
//
//  Created by bidlive on 2022/6/6.
//

#import "BidLiveHomeNetworkModel.h"
#import "BidLiveHomeCMSArticleModel.h"
#import "BidLiveInterfaceEnum.h"
#import "MJExtension.h"

@implementation BidLiveHomeNetworkModel

+(void)getHomePageBannerList:(NSInteger)bannerId client:(NSString *)client completion:(nonnull void (^)(NSArray<BidLiveHomeBannerModel *> * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppWebApiAddress,kGetBannerList];
    NSDictionary *params = @{@"id":@(bannerId),@"client":client};
    
    [HJNetwork POSTWithURL:url parameters:params callback:^(id responseObject, BOOL isCache, NSError *error) {
        if ([responseObject isKindOfClass:NSDictionary.class]) {
            if ([responseObject[@"success"] boolValue]) {
                NSArray *list = [BidLiveHomeBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
                !completionBlock?:completionBlock(list);
            }
        }else {
            !completionBlock?:completionBlock(@[]);
        }
    }];
}


+(void)getHomePageArticleList:(int)pageIndex pageSize:(int)pageSize completion:(nonnull void (^)(NSArray<BidLiveHomeCMSArticleModel *> * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@?pageIndex=%d&pageSize=%d",kAppEnApiAddress,kGetCMSArticleList,pageIndex,pageSize];
    
    [HJNetwork POSTWithURL:url parameters:nil callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock(@[]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                NSArray *list = [BidLiveHomeCMSArticleModel mj_objectArrayWithKeyValuesArray:responseObject[@"List"]];
                !completionBlock?:completionBlock(list);
            }else{
                !completionBlock?:completionBlock(@[]);
            }
        }
    }];
}

+(void)getHomePageGlobalLiveList:(NSString *)source completion:(void (^)(NSArray<BidLiveHomeGlobalLiveModel *> * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppWebApiAddress,kGetListForIndex];
    NSDictionary *params = @{@"source":source};
    
    [HJNetwork POSTWithURL:url parameters:params callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock(@[]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                NSArray *list = [BidLiveHomeGlobalLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
                !completionBlock?:completionBlock(list);
            }else{
                !completionBlock?:completionBlock(@[]);
            }
        }
    }];
}

+(void)getHomePageHotCourse:(int)pageIndex pageSize:(int)pageSize pageCount:(int)pageCount completion:(nonnull void (^)(BidLiveHomeHotCourseModel * _Nonnull))completionBlock {
    NSString *url = [NSString stringWithFormat:@"%@%@",kAppNewttpApiAddress,kGetHomeHotCourse];
    NSDictionary *params = @{@"pageIndex":@(pageIndex),
                             @"pageSize":@(pageSize),
                             @"pageCount":@(pageCount)
    };
    
    [HJNetwork POSTWithURL:url parameters:params callback:^(id responseObject, BOOL isCache, NSError *error) {
        if (error) {
            !completionBlock?:completionBlock([BidLiveHomeHotCourseModel new]);
        }else {
            if ([responseObject isKindOfClass:NSDictionary.class]) {
                if ([responseObject[@"result"] isKindOfClass:NSDictionary.class]) {
                    BidLiveHomeHotCourseModel *model = [BidLiveHomeHotCourseModel mj_objectWithKeyValues:responseObject[@"result"]];
                    !completionBlock?:completionBlock(model);
                }
            }else{
                !completionBlock?:completionBlock([BidLiveHomeHotCourseModel new]);
            }
        }
    }];
}

@end
