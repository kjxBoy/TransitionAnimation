//
//  BJAlertController.m
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BJAlertController.h"
#import "BJToolTransitioningDelegate.h"
#import "Masonry.h"

typedef void(^Block)(UIButton *button);

@interface BJAlertController ()


@property (nonatomic, strong)BJToolTransitioningDelegate* delegate;
@property (nonatomic, assign)BJAlertControllerStyle style;

@property (nonatomic, copy)Block successBlock;
@property (nonatomic, copy)Block cancelBlock;


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
    
    if (_style == BJAlertControllerAddFavourateCar) {
        [self initFavourateCarUI];
    }
    
}

- (void)initFavourateCarUI {
    if (_style == BJAlertControllerAddFavourateCar) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        titleLabel.text = @"提示";
        titleLabel.textColor = [UIColor blackColor];
        [self.view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@21);
            make.centerX.equalTo(self.view);
        }];
        
        
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.text = @"车辆删除后您的认证信息将彻底被删除，确定要删除吗？";
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:14];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 2;
        [self.view addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.view).offset(33);
            make.right.equalTo(self.view).offset(-33);
            make.height.equalTo(@40);
        }];
        
        UIButton *cancelButton = [[UIButton alloc] init];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:[UIColor lightGrayColor]];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.clipsToBounds = YES;
        cancelButton.layer.cornerRadius = 22;
        [self.view addSubview:cancelButton];
        [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@120);
            make.height.equalTo(@44);
            make.left.equalTo(self.view).offset(20);
            make.bottom.equalTo(self.view).offset(-20);
        }];
        
        UIButton *sureButton = [[UIButton alloc] init];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [sureButton setBackgroundColor:[UIColor blueColor]];
        sureButton.clipsToBounds = YES;
        sureButton.layer.cornerRadius = 22;
        [self.view addSubview:sureButton];
        [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@120);
            make.height.equalTo(@44);
            make.right.equalTo(self.view).offset(-20);
            make.bottom.equalTo(cancelButton);
        }];
        
        
    }
}

- (void)sureButtonClick:(UIButton *)button {
    if (self.successBlock) {
        self.successBlock(button);
    }
}

- (void)cancelButtonClick:(UIButton *)button {
    if (self.cancelBlock) {
        self.cancelBlock(button);
    }
}

+ (instancetype)alertControllerWithStyle:(BJAlertControllerStyle)style withSuccessBlcok:(Block)successBlock cancelBlock:(Block)cancelBlock {
    BJAlertController *alertController = [[BJAlertController alloc] init];
    alertController.successBlock = successBlock;
    alertController.cancelBlock = cancelBlock;
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
