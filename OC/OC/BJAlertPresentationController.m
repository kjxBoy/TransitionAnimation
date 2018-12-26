//
//  BJAlertPresentationController.m
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BJAlertPresentationController.h"

@interface BJAlertPresentationController ()

@property (nonatomic, strong)UIView *maskView;

@end

@implementation BJAlertPresentationController

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        _maskView.frame = self.containerView.bounds;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_maskView addGestureRecognizer:tapGesture];
    }
    return _maskView;
}

//MARK: - 改变了ContainerView里面的subView的frame （但是直接从控制器vc.View.frame没有改变）
//要调用方法"BJToolTransitioningDelegate里面的transitionContext.finalFrame(for: animateVc!)"来获得相应的frame

//自定义展现视图的frame
- (CGRect)frameOfPresentedViewInContainerView {
    
    CGRect containerViewBounds = self.containerView.bounds;
    
    CGRect newRect = CGRectZero;
    newRect.size = CGSizeMake(containerViewBounds.size.width * 0.6, containerViewBounds.size.height * 0.6);
    
    CGFloat x = containerViewBounds.size.width * 0.2;
    CGFloat y = 56.0;
    
    newRect.origin = CGPointMake(x, y);
    return newRect;
}




//在呈现过渡即将开始的时候被调用的
- (void)presentationTransitionWillBegin {
    [self.containerView insertSubview:self.maskView atIndex:0];
}

//在退出过渡即将开始的时候被调用的
- (void)dismissalTransitionWillBegin {
    [_maskView setHidden:YES];
}

- (void)tap {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
