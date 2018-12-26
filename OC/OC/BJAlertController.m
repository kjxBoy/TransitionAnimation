//
//  BJAlertController.m
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BJAlertController.h"
#import "BJToolTransitioningDelegate.h"

@interface BJAlertController ()

@property (nonatomic, strong)BJToolTransitioningDelegate* delegate;
@property (nonatomic, assign)BJAlertControllerStyle style;

@end

@implementation BJAlertController

- (BJToolTransitioningDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[BJToolTransitioningDelegate alloc] init];
    }
    return _delegate;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)initUI {
    if (_style == BJAlertControllerAddFavourateCar) {
        
        
        
        
    }
}

+ (instancetype)alertControllerWithStyle:(BJAlertControllerStyle)style {
    BJAlertController *alertController = [[BJAlertController alloc] init];
    alertController.style = style;
    [alertController commonInit];
    return alertController;
}

- (void)commonInit {
    self.modalPresentationStyle = UIModalPresentationCustom;
    //transition 转场，转成代理
    if (_style == BJAlertControllerAddFavourateCar) {
        self.delegate.alertSize = CGSizeMake(295, 177);
    }
    self.transitioningDelegate = self.delegate;
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
