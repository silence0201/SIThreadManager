//
//  ViewController.m
//  SIThreadManagerDemo
//
//  Created by Silence on 2020/8/27.
//  Copyright © 2020年 Silence. All rights reserved.
//

#import "ViewController.h"
#import "SIThreadManager.h"

@interface ViewController ()

@property (nonatomic, strong) SIThread *dataBaseThread;
@property (nonatomic, strong) SIThread *parseThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SIThreadManager *manager = [SIThreadManager manager];
    
    self.dataBaseThread = [manager threadWithName:@"DataBase"];
    self.parseThread = [manager threadWithName:@"Parse"];
}

- (void)testFunc {
    NSThread *thread = [NSThread currentThread];
    NSLog(@"在线程:%@,执行方法",thread.name);
}

- (IBAction)dataBaseThreadExcute {
    [self.dataBaseThread excuteSelectorOf:self selector:@selector(testFunc)];
    
    [self.dataBaseThread excuteTaskWithBlock:^{
        NSThread *thread = [NSThread currentThread];
        NSLog(@"在线程:%@,执行方法 Block",thread.name);
    }];
}

- (IBAction)parseThreadExcute {
    [self.parseThread excuteSelectorOf:self selector:@selector(testFunc)];
    
    [self.parseThread excuteTaskWithBlock:^{
        NSThread *thread = [NSThread currentThread];
        NSLog(@"在线程:%@,执行方法 Block",thread.name);
    }];
}

- (IBAction)stopThread {
    [self.dataBaseThread stop];
}
- (IBAction)startThread {
    [self.dataBaseThread becomeActivity];
}

@end
