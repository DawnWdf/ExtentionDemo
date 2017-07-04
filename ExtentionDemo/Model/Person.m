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

EXT_ObjectCodingImplmentation

#pragma mark - 复制

EXT_ObjectCopyImplmentation


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
@end
