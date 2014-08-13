//
//  PullTransitionManager.h
//  InteractiveTransition
//
//  Created by Camilo Vera Bezmalinovic on 5/19/14.
//  Copyright (c) 2014 Skout Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, PullTransitionManagerState){
    PullTransitionManagerStateDismissing = 0,
    PullTransitionManagerStatePresenting
};

@class ViewController;
@class SecondViewController;

@interface PullTransitionManager : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic)        PullTransitionManagerState state;
@property (nonatomic,weak)   ViewController             *mainViewController;
@property (nonatomic,strong) UINavigationController     *modalViewController;
@end
