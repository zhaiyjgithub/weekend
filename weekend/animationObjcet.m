//
//  animationObjcet.m
//  POPping
//
//  Created by chuck on 15-6-9.
//  Copyright (c) 2015年 ZK. All rights reserved.
//

#import "animationObjcet.h"
#import "ViewController.h"
#import "detailItemViewController.h"

@implementation animationObjcet


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    // 可以看做为destination ViewController
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 可以看做为source ViewController
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 添加toView到容器上
    [[transitionContext containerView] addSubview:toViewController.view];
    
    UIView * container = [transitionContext containerView];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([fromVC isKindOfClass:[ViewController class]]) { //push
        toViewController.view.alpha = 0.0;
        UIImageView * toViewFoodImageView = ((detailItemViewController *)toViewController).headImageView;
        
        toViewFoodImageView.frame = CGRectMake(-500, -320, 568, 320);
        
        [UIView animateWithDuration:0.5f animations:^{
            toViewController.view.alpha = 1.0;
            CGFloat imageScale = 16.0f/9;
            int x2 = 320*imageScale;
            int originX = -((x2 - 320.0)/2);
            toViewFoodImageView.frame = CGRectMake(originX, -320, x2, 320);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if ([fromVC isKindOfClass:[detailItemViewController class]]){//pop
        toViewController.view.alpha = 0.0f;
        UIImageView * fromFoodImageView = ((detailItemViewController *)fromVC).headImageView;
        [UIView animateWithDuration:0.15f animations:^{
            toViewController.view.alpha = 1.0f;
            fromFoodImageView.frame = CGRectMake(20, 400, 320, 180);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}




@end
