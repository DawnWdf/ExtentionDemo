//
//  HHNotifier.m
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/6/22.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "HHNotifier.h"

@interface HHNotifier()

@property (nonatomic, strong) NSHashTable *observers;
@property (nonatomic, strong) dispatch_semaphore_t lock;

@end

@implementation HHNotifier

#pragma mark - init


+ (id)alloc{
    return [HHNotifier notifier:NO];
}

+ (instancetype)notifier {
    return [HHNotifier notifier:NO];
}
+ (instancetype)retainNotifier{
    return [HHNotifier notifier:YES];
}

+ (instancetype)notifier:(BOOL)shouldRetainObserver {
    HHNotifier *notifier = [super alloc];
    notifier.observers = [NSHashTable hashTableWithOptions:shouldRetainObserver?NSPointerFunctionsStrongMemory:NSPointerFunctionsWeakMemory];
    return notifier;
}

#pragma mark - interface

- (BOOL)hasObserver{
    return self.observers.allObjects.count > 0;
}
- (void)addObserver:(id)observer {
    if (observer) {
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        [self.observers addObject:observer];
        dispatch_semaphore_signal(self.lock);
    }
}
- (void)removeObserver:(id)observer {
    if (observer) {
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        [self.observers removeObject:observer];
        dispatch_semaphore_signal(self.lock);
    }
}

#pragma mark - over write

- (BOOL)respondsToSelector:(SEL)aSelector {
    
    __block BOOL canResponse = NO;
    
    [self.observers.allObjects enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:aSelector]) {
            canResponse = YES;
            *stop = YES;
        }
    }];
    
    return canResponse;
//    for (id ob in self.observers.allObjects) {
//        if ([ob respondsToSelector:aSelector]) {
//            return YES;
//        }
//    }
//    return NO;
}



- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    
    for (id ob in self.observers.allObjects) {
        NSMethodSignature *signature = [ob methodSignatureForSelector:sel];
        if (signature) {
            return signature;
        }
    }
    return [super methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    for (id ob in self.observers.allObjects) {
        if ([ob respondsToSelector:invocation.selector]) {
            [invocation invokeWithTarget:ob];
        }
    }
}

#pragma mark - getter & setter

- (dispatch_semaphore_t)lock{
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = dispatch_semaphore_create(1);
    });
    
    return lock;
}

@end
