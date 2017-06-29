//
//  NSArray+DWLog.m
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/5/27.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import "NSArray+DWLog.h"

@implementation NSArray (DWLog)

- (NSString *)descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    NSMutableString *mStr = [NSMutableString string];
    NSMutableString *tab = [NSMutableString stringWithString:@""];
    for (int i = 0; i < level; i++) {
        [tab appendString:@"\t"];
    }
    [mStr appendString:@"(\n"];
    for (int i = 0; i < self.count; i++) {
        NSString *lastSymbol = (self.count == i + 1) ? @"":@",";
        id value = self[i];
        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
            [mStr appendFormat:@"\t%@%@%@\n",tab,[value descriptionWithLocale:locale indent:level + 1],lastSymbol];
        }else{
            [mStr appendFormat:@"\t%@%@%@\n",tab,value,lastSymbol];
        }
    }
    
    [mStr appendFormat:@"%@)",tab];
    return mStr;
}
@end
