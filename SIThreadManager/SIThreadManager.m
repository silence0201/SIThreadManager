//
//  SIThreadManager.m
//  SIThreadManagerDemo
//
//  Created by Silence on 2020/8/27.
//  Copyright © 2020年 Silence. All rights reserved.
//

#import "SIThreadManager.h"

@interface SIThreadManager ()
@property (nonatomic, strong)  NSMutableDictionary *threads;
@end

@implementation SIThreadManager

+ (instancetype)manager {
    static SIThreadManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SIThreadManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _threads = [NSMutableDictionary dictionary];
    }
    return self;
}

- (SIThread *)threadWithName:(NSString *)name {
    SIThread *thread = [self.threads objectForKey:name];
    if (!thread) {
        thread = [SIThread activityThreadWithName:name];
        [self.threads setObject:thread forKey:name];
    }
    return thread;
}


@end
