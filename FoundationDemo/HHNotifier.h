//
//  HHNotifier.h
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/6/22.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HHNotifObservers(action) if (self.observers.hasObserver) { [self.observers action]; }

@interface HHNotifier : NSProxy

+ (instancetype)notifier;
+ (instancetype)retainNotifier;

- (BOOL)hasObserver;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
@end
