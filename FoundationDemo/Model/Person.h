//
//  Person.h
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/6/14.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>



@interface Person : NSObject <NSCoding,NSCopying>
@property (nonatomic, copy) NSString *name1;
@property (nonatomic, copy) NSString *name2;
@property (nonatomic, copy) NSString *name3;
@property (nonatomic, copy) NSString *name4;
@property (nonatomic, strong) Person *son;
@property (nonatomic, strong)  NSArray<Person *> *flowers;
@property (nonatomic) NSInteger age;
@property (nonatomic) float height;
@end
