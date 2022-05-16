//
//  MCSearchShareGroupModel.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCSearchShareGroupModel : NSObject
@property (nonatomic, copy) NSString *shareGroupName;//群名称
@property (nonatomic, strong) NSNumber *memberCount;//群成员人数
@property (nonatomic, copy) NSString *nickName;//用户昵称
@property (nonatomic, copy) NSString *memberName;//人员名称
@property (nonatomic, copy) NSString *searchKey;//搜索关键字
@end

NS_ASSUME_NONNULL_END
