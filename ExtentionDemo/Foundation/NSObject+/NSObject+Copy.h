//
//  NSObject+Copy.h
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/6/27.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Copy)
- (id)ext_copyZone:(NSZone *)zone;

@end

#define CopyImplmentation \
- (id)copyWithZone:(NSZone *)zone { \
return [self ext_copyZone:zone];\
}\
//\
//-(id)mutableCopyWithZone:(NSZone *)zone {\
//return [self dw_multableCopyZone:zone]; \
//}\

#define EXT_ObjectCopyImplmentation CopyImplmentation
