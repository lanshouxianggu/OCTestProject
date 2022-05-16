//
//  MCGetIPFromUrl.h
//  ChatClub
//
//  Created by 刘创 on 2021/7/27.
//  Copyright © 2021 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GetIpBlock)(BOOL success,NSString *error,NSString *ipStr);

@interface MCGetIPFromUrl : NSObject

@property (nonatomic, copy) GetIpBlock getIpBlock;
+(instancetype)shareInstance;
-(void)getIpFromUrl;
-(void)clean;
@end

NS_ASSUME_NONNULL_END
