//
//  GoodPerson.h
//  FoundationDemo
//
//  Created by Dawn Wang on 2017/6/27.
//  Copyright © 2017年 Dawn Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface GoodPerson : Person <NSCoding>

@property (nonatomic, strong) NSArray *goodThings;

@property (nonatomic, strong) GoodPerson *goodPersonSon;

@property (nonatomic, strong) NSArray <GoodPerson *> *goodFlowers;

@end
