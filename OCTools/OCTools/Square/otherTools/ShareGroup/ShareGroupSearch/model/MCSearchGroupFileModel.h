//
//  MCSearchGroupFileModel.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCSearchGroupFileModel : NSObject
@property (nonatomic, copy) NSString *fileName;//文件/文件夹名称
@property (nonatomic, copy) NSString *groupName;//所属共享群名称
@property (nonatomic, copy) NSString *searchKey;//搜索关键字
@end

NS_ASSUME_NONNULL_END
