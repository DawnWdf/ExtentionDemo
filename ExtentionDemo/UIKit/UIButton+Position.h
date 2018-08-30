//
//  UIButton+Position.h
//  ExtentionDemo
//
//  Created by Dawn Wang on 2018/8/28.
//  Copyright © 2018年 Dawn Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ButtonImagePosition_Left,
    ButtonImagePosition_right,
    ButtonImagePosition_top,
    ButtonImagePosition_bottom
}ButtonImagePosition;

@interface UIButton (Position)

- (void)setImagePosition:(ButtonImagePosition)position;

- (void)setImagePosition:(ButtonImagePosition)position pading:(CGFloat)pading;

@end
