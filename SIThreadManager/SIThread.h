//
//  SIThread.h
//  SIThreadManagerDemo
//
//  Created by Silence on 2020/8/27.
//  Copyright © 2020年 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SIThread : NSObject

@property (nonatomic, strong) NSString *threadName;

+ (SIThread *)activityThreadWithName:(NSString *)name;

- (void)becomeActivity;
- (void)stop;

-(void)excuteTaskWithBlock:(void (^)(void))block;

- (void)excuteSelectorOf:(id)obj selector:(SEL)aSelector;
- (void)excuteSelectorOf:(id)obj selector:(SEL)aSelector withArgu:(nullable id)anArgument;
- (void)excuteSelectorOf:(id)obj selector:(SEL)aSelector withArgu:(nullable id)anArgument waitUntilDone:(BOOL)wait;

@end

NS_ASSUME_NONNULL_END
