//
//  ViewController.m
//  InteractiveTransition
//
//  Created by Camilo Vera Bezmalinovic on 5/19/14.
//  Copyright (c) 2014 Skout Inc. All rights reserved.
//

#import "ViewController.h"
#import "PullTransitionManager.h"
@interface ViewController () <UIViewControllerTransitioningDelegate>
@property (nonatomic,strong) PullTransitionManager                *transition;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *transitionController;
@property (nonatomic,strong) UIViewController                     *nextViewController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transition = [PullTransitionManager new];
    
    self.transitioningDelegate = self;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(didRecognizeMainPanGesture:)];
    
    [self.view addGestureRecognizer:panGesture];
}

- (void)didRecognizeMainPanGesture:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        _transitionController = [UIPercentDrivenInteractiveTransition new];
        _transitionController.completionCurve = UIViewAnimationCurveEaseOut;
        
        [self performSegueWithIdentifier:@"next" sender:self];
        
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGFloat rate = MAX(-[gesture translationInView:gesture.view].y,0)/CGRectGetHeight(gesture.view.bounds);
        [_transitionController updateInteractiveTransition:rate];
        NSLog(@"Rate %f",rate);
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGFloat velocity = [gesture velocityInView:gesture.view].y;
        if (velocity < 0)
        {
            NSLog(@"Dragging UP");
            [_transitionController finishInteractiveTransition];
        }
        else
        {
            [_transitionController cancelInteractiveTransition];
            NSLog(@"Cancel Transition");
        }
        _transitionController = nil;
    }
}


- (IBAction)unwindToFirstFromSecond:(UIStoryboardSegue *)segue
{

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"next"])
    {
        [segue.destinationViewController setTransitioningDelegate:self];
        [segue.destinationViewController setModalPresentationStyle:UIModalPresentationCustom];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(didRecognizeNavigationBarPanGesture:)];
        
        [[segue.destinationViewController view] addGestureRecognizer:panGesture];
        
        _nextViewController = segue.destinationViewController;
    }
}

- (void)didRecognizeNavigationBarPanGesture:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        _transitionController = [UIPercentDrivenInteractiveTransition new];
        _transitionController.completionCurve = UIViewAnimationCurveEaseOut;
        [_nextViewController performSegueWithIdentifier:@"back" sender:self];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        CGFloat rate = MAX([gesture translationInView:gesture.view].y,0)/ CGRectGetHeight(self.view.bounds);
        [_transitionController updateInteractiveTransition:rate];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGFloat velocity = [gesture velocityInView:gesture.view].y;
        if (velocity > 0)
        {
            [_transitionController finishInteractiveTransition];
        }
        else
        {
            [_transitionController cancelInteractiveTransition];
            
        }
        _transitionController = nil;
    }
}
#pragma mark - animation Delegates
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    _transition.state = PullTransitionManagerStatePresenting;
    return _transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _transition.state = PullTransitionManagerStateDismissing;
    return _transition;
}

// Implement these 2 methods to perform interactive transitions
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    return _transitionController;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    return _transitionController;
}


@end
