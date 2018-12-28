//
//  BJToolTransitioningDelegate.m
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BJToolTransitioningDelegate.h"
#import "BJAlertPresentationController.h"

@interface BJToolTransitioningDelegate () <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate>


@property (nonatomic, assign)BOOL isPop;

@end

@implementation BJToolTransitioningDelegate


#pragma mark - UIViewControllerAnimatedTransitioning

//转场时间
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *from = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *to = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *animteView = self.isPop ? to : from;
    
    animteView.clipsToBounds = YES;
    animteView.layer.cornerRadius = 12;
    
    animteView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    animteView.frame = CGRectMake(0, 0, self.alertSize.width, self.alertSize.height);
    animteView.center = CGPointMake(transitionContext.containerView.bounds.size.width * 0.5, transitionContext.containerView.bounds.size.height * 0.5);
    
    
    CGFloat damping = 3.0;
    if (self.isPop) {
        [transitionContext.containerView addSubview:animteView];
        damping = 0.75;
    }
    CGAffineTransform transformBig = CGAffineTransformMakeScale(1.1, 1.1);
    
    animteView.transform = self.isPop ? transformBig : CGAffineTransformIdentity;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:damping
          initialSpringVelocity:5.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         animteView.transform = CGAffineTransformIdentity;
                         if (!self.isPop)
                             animteView.alpha = 0.02;
                     } completion:^(BOOL finished) {
                         if (!self.isPop)
                             [animteView removeFromSuperview];
                        [transitionContext completeTransition:YES];
    }];
    
   
    
    
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
    return [[BJAlertPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.isPop = NO;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.isPop = YES;
    return self;
}

@end
