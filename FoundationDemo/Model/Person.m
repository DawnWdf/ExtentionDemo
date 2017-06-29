//
//  Person.m
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/6/14.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "NSObject+Coding.h"
#import "NSObject+Copy.h"

@interface Person()
{
    @private
    NSString *privateString;
}

@end

@implementation Person

#pragma mark - 归档

DWObjectCodingImplmentation

#pragma mark - 复制

DWObjectCopyImplmentation


#pragma mark - key_value to medel

+ (NSDictionary *)arrayContainModel{
    return @{@"flowers":@"Person"};
}

#pragma mark - description
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level
{
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tab = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tab appendString:@"\t"];
    }
    [mStr appendFormat:@"<%@ = {\n",NSStringFromClass(self.class)];
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        const char *charProperty = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:charProperty];
        if (propertyName) {
            id propertyValue = [self valueForKey:propertyName];
            NSString *lastSymbol = (outCount == i + 1) ? @"":@";";
            if ([propertyValue respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
                [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,propertyName,[propertyValue descriptionWithLocale:locale indent:level + 1],lastSymbol];
            } else {
                [mStr appendFormat:@"\t%@%@ = %@%@\n",tab,propertyName,propertyValue,lastSymbol];
            }
        }
    }
    free(properties);
    [mStr appendFormat:@"%@}>",tab];
    return mStr;
}

//void dynamicMethodIMP(id self, SEL _cmd){
//    NSLog(@"动态添加的方法 感觉没什么使用价值 反正就算返回no也会查找其他资源");
//}


/**
 当对象要去通过sel找实现的的方法之前调用 如果找到了 返回yes 如果没找到 返回no

 @param sel 方法
 @return 是否可执行的布尔值
 */
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    
//    if (sel == @selector(aMethodWitchNotIMP)) {
//        class_addMethod(self, sel, (IMP)dynamicMethodIMP, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];;
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    
//}
@end
