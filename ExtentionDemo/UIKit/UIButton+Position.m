//
//  UIButton+Position.m
//  ExtentionDemo
//
//  Created by Dawn Wang on 2018/8/28.
//  Copyright © 2018年 Dawn Wang. All rights reserved.
//

#import "UIButton+Position.h"

@implementation UIButton (Position)
- (void)setImagePosition:(ButtonImagePosition)position {
    [self setImagePosition:position pading:10];
}

- (void)setImagePosition:(ButtonImagePosition)position pading:(CGFloat)pading {
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;

    
    CGFloat imageOffsetXLeft  = 0;
    CGFloat imageOffsetYTop = 0;
    
    CGFloat titleOffsetXLeft =  0;
    CGFloat titleOffsetYTop = 0;
    
    CGFloat imageOffsetXRight  = 0;
    CGFloat imageOffsetYBottom = 0;
    
    CGFloat titleOffsetXRight =  0;
    CGFloat titleOffsetYBottom = 0;
    
    
    switch (position) {
        case ButtonImagePosition_Left:
            //默认情况是图片在左，所以此时不管横纵向配置是什么都只配置横向间距即可
            imageOffsetXRight = pading;
            titleOffsetXLeft = pading;
            break;
        case ButtonImagePosition_right:
            //图片在右
            

            if ( self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft || self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
                imageOffsetXLeft  = labelWidth + pading;
                titleOffsetXLeft = -imageWidth;// -((imageWidth + labelWidth)  / 2) + pading / 2;
                
                imageOffsetXRight = -(labelWidth);
                titleOffsetXRight = imageWidth + pading ;
            }else{
                //图片中心横向位移：图片在右时的中心点-图片在左时中心点
                imageOffsetXLeft  = labelWidth + pading;
                imageOffsetXRight = -imageOffsetXLeft;
                
                //文字中心横向位移：
                titleOffsetXRight = (imageWidth);
                titleOffsetXLeft = -titleOffsetXRight;
            }
            break;
        case ButtonImagePosition_top:
            
            if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop || self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom) {
                imageOffsetYTop = 0;
                imageOffsetYBottom = labelHeight +pading;
                titleOffsetYBottom = 0;
                titleOffsetYTop = imageHeight +pading;
                
            }else{
                imageOffsetYBottom = (labelHeight + pading)/2;
                imageOffsetYTop = -imageOffsetYBottom;
                titleOffsetYTop = (imageHeight + pading )/2;
                titleOffsetYBottom = -titleOffsetYTop;
                
            }
            
            

            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight || self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                if (imageWidth > labelWidth) {
                    imageOffsetXRight = -labelWidth;
                    titleOffsetXRight = fabs(imageWidth - labelWidth) / 2;
                    imageOffsetXLeft = 0;
                    titleOffsetXLeft = -imageWidth + fabs(imageWidth - labelWidth) / 2;
                }else{
                    imageOffsetXRight =  -labelWidth + fabs(imageWidth - labelWidth) / 2;
                    titleOffsetXRight = 0;
                    imageOffsetXLeft = fabs(imageWidth - labelWidth) / 2;
                    titleOffsetXLeft = -imageWidth;
                }
            }else{
                imageOffsetXLeft = labelWidth / 2;
                imageOffsetXRight = -imageOffsetXLeft;
                titleOffsetXRight = imageWidth / 2;
                titleOffsetXLeft = -titleOffsetXRight;
            }

            break;
        case ButtonImagePosition_bottom:
            if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentTop || self.contentVerticalAlignment == UIControlContentVerticalAlignmentBottom) {
                imageOffsetYBottom = 0;
                imageOffsetYTop = labelHeight +pading;
                
                titleOffsetYTop = 0;
                titleOffsetYBottom = imageHeight + pading;
            }else{
                imageOffsetYTop = (labelHeight+ imageHeight + pading)/2;
                imageOffsetYBottom = -imageOffsetYBottom;
                titleOffsetYTop = -(imageHeight+ pading + labelHeight) / 2;
                titleOffsetYBottom = -titleOffsetYBottom;
            }
            
          
            
            if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight || self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentLeft) {
                if (imageWidth > labelWidth) {
                    imageOffsetXRight = -labelWidth;
                    titleOffsetXRight = fabs(imageWidth - labelWidth) / 2;
                    imageOffsetXLeft = 0;
                    titleOffsetXLeft = -imageWidth + fabs(imageWidth - labelWidth) / 2;
                }else{
                    imageOffsetXRight =  -labelWidth + fabs(imageWidth - labelWidth) / 2;
                    titleOffsetXRight = 0;
                    imageOffsetXLeft = fabs(imageWidth - labelWidth) / 2;
                    titleOffsetXLeft = -imageWidth;
                }
            }else{
                imageOffsetXLeft = labelWidth / 2;
                imageOffsetXRight = -imageOffsetXLeft;
                titleOffsetXLeft = -imageWidth / 2;
                titleOffsetXRight = -titleOffsetXLeft;
            }
            break;
        default:
            break;
    }
   
    UIEdgeInsets imageEdge = UIEdgeInsetsMake(imageOffsetYTop,imageOffsetXLeft,imageOffsetYBottom,imageOffsetXRight);
  
    UIEdgeInsets titleEdge = UIEdgeInsetsMake(titleOffsetYTop,titleOffsetXLeft,titleOffsetYBottom,titleOffsetXRight);
    
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
}

@end
