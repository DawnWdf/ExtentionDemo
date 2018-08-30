//
//  UIButton+Position.h
//  ExtentionDemo
//
//  Created by Dawn Wang on 2018/8/28.
//  Copyright © 2018年 Dawn Wang. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 图片的上下坐相对于按钮，文字上下右相对于按钮，文字左面相对于图片右面
 配置不同的对齐方式时
 如：上+左
 判断图片和文字上边距和左边距移动的相对距离
 如：中心
 判断图片和文字中心点移动的相对距离
*/

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
