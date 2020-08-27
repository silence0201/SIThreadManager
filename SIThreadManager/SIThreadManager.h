//
//  SIThreadManager.h
//  SIThreadManagerDemo
//
//  Created by Silence on 2020/8/27.
//  Copyright © 2020年 Silence. All rights reserved.
//

#import "SIThread.h"

NS_ASSUME_NONNULL_BEGIN

@interface SIThreadManager : NSObject

+ (instancetype)manager;

- (SIThread *)threadWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
