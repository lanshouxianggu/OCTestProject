//
//  ShareGroupModel.h
//  ChatClub
//
//  Created by ArcherMind on 2020/7/30.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareGroupModel : NSObject

@property (nonatomic, strong) NSString *headImageUrl;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSString *groupDesc;
@property (nonatomic, strong) NSString *updateDate;

@end

NS_ASSUME_NONNULL_END
