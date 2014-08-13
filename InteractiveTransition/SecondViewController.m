//
//  SecondViewController.m
//  InteractiveTransition
//
//  Created by Camilo Vera Bezmalinovic on 5/19/14.
//  Copyright (c) 2014 Skout Inc. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *transitionController;
@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    }

- (void)didRecognizeNavigationBarPanGesture:(UIPanGestureRecognizer *)gesture
{


}



@end
