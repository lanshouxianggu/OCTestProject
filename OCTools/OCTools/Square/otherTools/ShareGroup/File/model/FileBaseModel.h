//
//  FileBaseModel.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/7.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FileBaseModel : NSObject
@property (nonatomic, assign) BOOL isAllSelect;
@property (nonatomic, strong) NSArray<FileModel *> *dataArray;
@property (nonatomic, assign) NSInteger selectCount;
@end

NS_ASSUME_NONNULL_END
