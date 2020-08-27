//
//  SIThread.m
//  SIThreadManagerDemo
//
//  Created by Silence on 2020/8/27.
//  Copyright © 2020年 Silence. All rights reserved.
//

#import "SIThread.h"

@interface SIThread ()

@property (nonatomic, strong) NSThread *aThread;

@property (nonatomic, assign) BOOL canceled;

@property (nonatomic, strong) NSLock *lock;

@end

@implementation SIThread

- (instancetype)init {
    if (self = [super init]) {
        _canceled = NO;
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (void)startRunLoop {
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    NSMachPort *port = [[NSMachPort alloc] init];
    [runLoop addPort:port forMode:NSDefaultRunLoopMode];
    while (!self.canceled) {
        [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
}

- (void)setThreadName:(NSString *)threadName {
    _threadName = threadName;
    self.aThread.name = threadName;
}

- (void)becomeActivity {
    [self.lock lock];
    if (!self.aThread) {
        self.aThread = [[NSThread alloc] initWithTarget:self selector:@selector(startRunLoop) object:nil];
        self.aThread.name = _threadName;
        [self.aThread start];
    }
    [self.lock unlock];
}

- (void)excuteSelectorOf:(id)obj selector:(SEL)aSelector {
    [self excuteSelectorOf:obj selector:aSelector withArgu:nil];
}

- (void)excuteSelectorOf:(id)obj selector:(SEL)aSelector withArgu:(nullable id)anArgument {
    [self excuteSelectorOf:obj selector:aSelector withArgu:anArgument waitUntilDone:NO];
}

- (void)excuteSelectorOf:(id)obj selector:(SEL)aSelector withArgu:(nullable id)anArgument waitUntilDone:(BOOL)wait {
    if (!self.aThread.isExecuting) return;
    if (![obj respondsToSelector:aSelector]) return;
    [obj performSelector:aSelector onThread:self.aThread withObject:anArgument waitUntilDone:wait];
}

- (void)excuteTaskWithBlock:(void (^)(void))block {
    if (!self.aThread || !block) return;
    [self performSelector:@selector(_excuteTask:) onThread:self.aThread withObject:block waitUntilDone:NO];
}

- (void)_excuteTask:(void (^)(void))block{
    block();
}

- (void)stop {
    [self.lock lock];
    if (self.aThread) {
        [self performSelector:@selector(stopRunLoop) onThread:self.aThread withObject:nil waitUntilDone:NO];
    }
    [self.lock unlock];
}

- (void)stopRunLoop {
    self.canceled = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.aThread = nil;
}

+ (SIThread *)activityThreadWithName:(NSString *)name {
    SIThread *thread = [[SIThread alloc] init];
    thread.threadName = name;
    [thread becomeActivity];
    return thread;
}

@end
