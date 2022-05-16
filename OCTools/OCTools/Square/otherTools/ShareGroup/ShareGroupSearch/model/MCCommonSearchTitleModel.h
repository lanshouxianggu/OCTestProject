//
//  MCCommonSearchTitleModel.h
//  ChatClub
//
//  Created by ArcherMind on 2020/9/22.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCCommonSearchTitleModel : NSObject
@property (nonatomic, copy) NSString *searchTitle;
@property (nonatomic, copy) NSString *displayTitle;
@property (nonatomic, assign) CGSize titleRect;
@end

NS_ASSUME_NONNULL_END
