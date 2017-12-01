//
//  ZJTabBar.m
//  BuldingMall
//
//  Created by Jion on 2017/11/29.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "ZJTabBar.h"
//尺寸
#define zScreenHeight [[UIScreen mainScreen] bounds].size.height
#define zScreenWidth [[UIScreen mainScreen] bounds].size.width
//状态栏高
#define statusBarH    CGRectGetHeight([UIApplication sharedApplication].statusBarFrame)
#define safeAreaBottomH  (statusBarH > 20 ? 34 : 0)

@interface ZJTabBar ()
{
    UIView *selctItem;
}
@end

@implementation ZJTabBar

#pragma mark - Override Methods
- (void)setFrame:(CGRect)frame
{
    if (self.superview &&CGRectGetMaxY(self.superview.bounds) !=CGRectGetMaxY(frame)) {
        frame.origin.y =CGRectGetHeight(self.superview.bounds) -CGRectGetHeight(frame);
    }
    [super setFrame:frame];
}

#pragma mark - Initial Methods
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    if (backgroundImage) {
        backgroundImage = [self stretchImg:backgroundImage LeftAndRightContainerSize:CGSizeMake(zScreenWidth, backgroundImage.size.height+safeAreaBottomH)];
        
    }
    [super setBackgroundImage:backgroundImage];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.centerBulge) {
        
        //iOS8 去掉TabBar上部的横线的方法
        for (UIView *view in self.subviews){
            
            if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1){
                //横线的高度为0.5
                UIImageView *line = (UIImageView *)view;
                line.hidden = YES;
                
            }
            
        }
        
        int btnIndex = 0;
        
        Class class = NSClassFromString(@"UITabBarButton");
        Class barBackground = NSClassFromString(@"_UIBarBackground");
        
        for (UIView *btn in self.subviews) {
            
            if ([btn isKindOfClass:class]) {
                NSArray *array = self.items;
                //如果索引是中间按钮
                if (btnIndex == array.count/2) {
                    
                    //UITabBarItem *item = array[btnIndex];
                    
                    //设置中心按钮的位置和大小
                    CGFloat centerX = self.center.x;
                    CGFloat centerY = self.bounds.size.height * 0.5 - 10 - safeAreaBottomH/2;
                    btn.center = CGPointMake(centerX, centerY);
                    
                    CGSize size = CGSizeMake(btn.bounds.size.width, btn.bounds.size.height*1.4);
                    btn.bounds = CGRectMake(0, 0, size.width, size.height);
                    selctItem = btn;
                }
                btnIndex++;
            }else if([btn isKindOfClass:barBackground]){
                //iOS11 去掉TabBar上部的横线的方法
                for (UIView *view in btn.subviews) {
                    if (view.opaque == YES) {
                        view.hidden = YES;
                    }
                }
            }
            
            
        }

        
    }
    
}
- (UIImage *)stretchImg:(UIImage*)img LeftAndRightContainerSize:(CGSize)size{
    
    CGSize imageSize = img.size;
    CGSize bgSize = size;
    
    //1.第一次拉伸右边 保护左边
    UIImage *image = [img stretchableImageWithLeftCapWidth:imageSize.width *0.8 topCapHeight:imageSize.height * 0.5];
    
    //第一次拉伸的距离之后图片总宽度
    CGFloat tempWidth = (bgSize.width)/2 + imageSize.width/2;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, bgSize.height), NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, tempWidth, bgSize.height)];
    
    //拿到拉伸过的图片
    UIImage *firstStrechImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //2.第二次拉伸左边 保护右边
    UIImage *secondStrechImage = [firstStrechImage stretchableImageWithLeftCapWidth:firstStrechImage.size.width *0.1 topCapHeight:firstStrechImage.size.height*0.5];
    
    return secondStrechImage;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    //这一个判断是关键，不判断的话push到其他页面，点击发布按钮的位置也是会有反应的，这样就不好了
    //self.isHidden == NO 说明当前页面是有tabbar的，那么肯定是在导航控制器的根控制器页面
    //在导航控制器根控制器页面，那么我们就需要判断手指点击的位置是否在发布按钮身上
    //是的话让发布按钮自己处理点击事件，不是的话让系统去处理点击事件就可以了
    if (!self.isHidden && self.centerBulge) {
        //将当前tabbar的触摸点转换坐标系，转换到发布按钮的身上，生成一个新的点
        CGPoint newPoint = [self convertPoint:point toView:selctItem];
        //判断如果这个新的点是在突出的按钮身上，那么处理点击事件最合适的view就是突出的按钮
        if ([selctItem pointInside:newPoint withEvent:event]) {
            return selctItem;
        }else{
            //如果点不在突出的按钮身上，直接让系统处理就可以了
            return [super hitTest:point withEvent:event];
        }
    }else{
        //tabbar隐藏了，那么说明已经push到其他的页面了，这个时候还是让系统去判断最合适的view处理就好了
        return [super hitTest:point withEvent:event];
    }
    
}

@end
