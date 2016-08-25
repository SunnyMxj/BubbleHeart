//
//  UIView+bubbleHeart.m
//  bubbleHeart
//
//  Created by QianFan_Ryan on 16/8/25.
//  Copyright © 2016年 QianFan. All rights reserved.
//

#import "UIView+bubbleHeart.h"

static CGFloat imageWidth = 30.0f;
static CGFloat imageHeight = 25.0f;

@implementation UIView (bubbleHeart)

- (void)showBubbleHeartWithLocaltion:(CGPoint)location{
    CALayer *heartLayer = [[CALayer alloc]init];
    [heartLayer setFrame:CGRectMake(location.x - imageWidth/2, location.y + imageHeight/2, imageWidth, imageHeight)];
    heartLayer.contents=(__bridge id _Nullable)([[UIImage imageNamed:@"heart"] CGImage]);
    heartLayer.opacity = .0f;
    [self.layer addSublayer:heartLayer];
    [CATransaction begin];
    [CATransaction setCompletionBlock:^(){
        [heartLayer removeFromSuperlayer];
    }];
    
    CAAnimationGroup *animation = [self createAnimation:location];
    animation.duration = 4 + (arc4random_uniform(3) - 1);
    animation.fillMode = kCAFillModeForwards;
    [heartLayer addAnimation:animation forKey:nil];
    [CATransaction commit];

}

- (CAAnimationGroup *)createAnimation:(CGPoint)startPoint {
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    transformAnimation.duration = 0.2f;
    transformAnimation.fromValue = [NSNumber numberWithFloat:.1];
    transformAnimation.toValue = [NSNumber numberWithFloat:1];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    
    int height = -100 + arc4random_uniform(41) - 20;
    int xOffset = startPoint.x;
    int yOffset = startPoint.y;
    int waveWidth = 100;
    
    CGPoint cp1;
    CGPoint cp2;
    CGPoint endPoint = CGPointMake(xOffset + arc4random_uniform(waveWidth+1)- waveWidth/2, yOffset + height * 3);
    if (arc4random() % 2) {
        cp1 = CGPointMake(xOffset + arc4random_uniform(waveWidth+1) - waveWidth, yOffset + height);
        cp2 = CGPointMake(xOffset + arc4random_uniform(waveWidth+1), yOffset + height * 2);
    } else {
        cp1 = CGPointMake(xOffset + arc4random_uniform(waveWidth+1), yOffset + height);
        cp2 = CGPointMake(xOffset + arc4random_uniform(waveWidth+1) - waveWidth, yOffset + height * 2);
    }
    
    CGPathMoveToPoint(path, NULL, xOffset,yOffset);
    CGPathAddCurveToPoint(path, NULL, cp1.x, cp1.y, cp2.x, cp2.y, endPoint.x, endPoint.y);
    animation.path = path;
    animation.calculationMode = kCAAnimationCubicPaced;
    animation.removedOnCompletion = YES;
    CGPathRelease(path);
    
    //透明渐变
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue  = @0.01f;
    opacityAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    opacityAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[transformAnimation, animation, opacityAnimation];
    return animGroup;
}

@end
