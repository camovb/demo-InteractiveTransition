//
//  PullTransitionManager.m
//  InteractiveTransition
//
//  Created by Camilo Vera Bezmalinovic on 5/19/14.
//  Copyright (c) 2014 Skout Inc. All rights reserved.
//

#import "PullTransitionManager.h"
#import "ViewController.h"
#import "SecondViewController.h"

@implementation PullTransitionManager

#pragma mark - Transition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.40;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *vcFrom = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *vcTo   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect frameFromInitial = [transitionContext initialFrameForViewController:vcFrom];
    CGRect frameToFinal     = frameFromInitial;

    UIView *context = [transitionContext containerView];

    if (self.state == PullTransitionManagerStatePresenting)
    {
        CGRect frameToInitial = frameFromInitial;
        frameToInitial.origin.y = frameFromInitial.size.height;
        
        CGRect frameFromFinal = frameFromInitial;
        frameFromFinal.origin.y = - frameFromInitial.size.height;
        
        vcTo.view.frame   = frameToInitial;
        vcFrom.view.frame = frameFromInitial;
        [context insertSubview:vcTo.view aboveSubview:vcFrom.view];
        
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            vcTo.view.frame = frameToFinal;
            vcFrom.view.frame = frameFromFinal;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    else if (self.state == PullTransitionManagerStateDismissing)
    {
        CGRect frameToInitial   = frameFromInitial;
        frameToInitial.origin.y = -frameFromInitial.size.height;
        
        CGRect frameFromFinal   = frameFromInitial;
        frameFromFinal.origin.y = frameFromInitial.size.height;

        vcTo.view.frame   = frameToInitial;
        vcFrom.view.frame = frameFromInitial;
        [context insertSubview:vcTo.view belowSubview:vcFrom.view];

        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            vcTo.view.frame = frameToFinal;
            vcFrom.view.frame = frameFromFinal;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }

}

@end
