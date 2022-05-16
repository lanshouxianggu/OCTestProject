//
//  LCLongPressGestureRecognizer.h
//  ChatClub
//
//  Created by ArcherMind on 2020/8/10.
//  Copyright © 2020 ArcherMind. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCLongPressGestureRecognizer : UILongPressGestureRecognizer
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
