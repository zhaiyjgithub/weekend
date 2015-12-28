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
   // UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 添加toView到容器上
    [[transitionContext containerView] addSubview:toViewController.view];
    
  //  UIView * container = [transitionContext containerView];
    UIViewController * fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
   // UIViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([fromVC isKindOfClass:[ViewController class]]) { //push
        //toViewController.view.alpha = 0.0;
        UIImageView * toViewFoodImageView = ((detailItemViewController *)toViewController).bottomImageView;
        
        toViewFoodImageView.frame =  ((detailItemViewController *)toViewController).imageViewOriginRect;///CGRectMake(-500, -320, 568, 320);
        toViewController.view.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.3f animations:^{
            // toViewController.view.alpha = 1.0;
            CGFloat imageScale = 16.0f/9;
            int x2 = 320*imageScale;
            int originX = -((x2 - 320.0)/2);
            toViewFoodImageView.frame = CGRectMake(originX, 0, x2, 320);
        } completion:^(BOOL finished) {
            fromVC.view.backgroundColor = [UIColor whiteColor];
            toViewController.view.backgroundColor = [UIColor whiteColor];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else if ([fromVC isKindOfClass:[detailItemViewController class]]){//pop
        toViewController.view.alpha = 1.0f;
        UIImageView * fromFoodImageView = ((detailItemViewController *)fromVC).bottomImageView;
        ((ViewController *)toViewController).towerImageView.frame = fromFoodImageView.frame;
        [UIView animateWithDuration:0.5f animations:^{
            toViewController.view.alpha = 1.0f;
            //fromFoodImageView.frame =  ((detailItemViewController *)fromVC).imageViewOriginRect;//CGRectMake(20, 400, 320, 180);
            ((ViewController *)toViewController).towerImageView.frame = CGRectMake(80, 100 ,160, 90);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}




@end
