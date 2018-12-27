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




@interface BJAlertController ()


@property (nonatomic, strong)BJToolTransitioningDelegate* delegate;
@property (nonatomic, assign)BJAlertControllerStyle style;

@property (nonatomic, copy)AlertActionBlock successBlock;
@property (nonatomic, copy)AlertActionBlock cancelBlock;

@property (nonatomic, weak)UIButton *leftButton;
@property (nonatomic, weak)UIButton *rightButton;

@property (nonatomic, weak) BJAlertAction *leftAction;
@property (nonatomic, weak) BJAlertAction *rightAction;

@property (nonatomic, copy)NSString *actionTitle;
@property (nonatomic, copy)NSString *actionMessage;


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
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
        titleLabel.text = _actionTitle;
        titleLabel.textColor = [UIColor blackColor];
        [self.view addSubview:titleLabel];
    
        UILabel *messageLabel = [[UILabel alloc] init];
        messageLabel.text = _actionMessage;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:14];
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        [messageLabel setHighlighted:YES];
        [self.view addSubview:messageLabel];
    
        if ([self messageIsEmpty]) {
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@54);
                make.centerX.equalTo(self.view);
            }];
            return;
        }
    
        [messageLabel setHighlighted:NO];
    
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@21);
            make.centerX.equalTo(self.view);
        }];
    
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.view).offset(33);
            make.right.equalTo(self.view).offset(-33);
        }];
}

- (void)sureButtonClick:(UIButton *)button {
    if (self.successBlock) {
        self.successBlock(_leftAction);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancelButtonClick:(UIButton *)button {
    if (self.cancelBlock) {
        self.cancelBlock(_rightAction);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - public

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message withAlertStyle:(BJAlertControllerStyle)style {
    BJAlertController *alertController = [[BJAlertController alloc] init];
    alertController.style = style;
    [alertController commonInitWithTitle:(NSString *)title message:(NSString *)message];
    return alertController;
}

- (void)addAction:(BJAlertAction *)action {
    
    // 最多添加两个按钮
    if (_leftButton && _rightButton ) return;
    
    // 最多添加一个取消或者确认按钮
    if (self.cancelBlock && action.style == BJAlertActionStyleCancel) return;
    if (self.successBlock && action.style == BJAlertActionStyleDefault) return;
    
    
    UIButton *sureButton = [[UIButton alloc] init];
    [sureButton setTitle:action.title forState:UIControlStateNormal];
    
    switch (action.style) {
        case BJAlertActionStyleDefault: {
            [sureButton setBackgroundColor:[UIColor blueColor]];
            [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.successBlock = action.actionBlock;
            [sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case BJAlertActionStyleCancel: {
            [sureButton setBackgroundColor:[UIColor lightGrayColor]];
            [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.cancelBlock = action.actionBlock;
            [sureButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        default:
            break;
    }
    
    sureButton.clipsToBounds = YES;
    sureButton.layer.cornerRadius = 22;
    [self.view addSubview:sureButton];
   
    //如果只有一个按钮，居中
    if (!_leftButton) {
        _leftButton = sureButton;
        _leftAction = action;
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@120);
            make.height.equalTo(@44);
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-20);
        }];
        return;
    }
    // 最多两个按钮
    _rightButton = sureButton;
    _rightAction = action;
    [_leftButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@120);
        make.height.equalTo(@44);
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    
    [_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@120);
        make.height.equalTo(@44);
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-20);
    }];
    
}


#pragma mark - private

- (void)commonInitWithTitle:(NSString *)title message:(NSString *)message {
    // 使用custom不会隐藏fromview
    self.modalPresentationStyle = UIModalPresentationCustom;
    _actionTitle = title;
    _actionMessage = message;
    //  计算字体高度
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGFloat titleHeight = [message boundingRectWithSize:CGSizeMake(229, MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    CGFloat height = 137 + titleHeight;
    
    if ([self messageIsEmpty] ) {
        height = 177;
    }

    //transition 转场，转成代理
    if (_style == BJAlertControllerAddFavourateCar) {
        self.delegate.alertSize = CGSizeMake(295, height);
    }
    self.transitioningDelegate = self.delegate;
}

- (BOOL)messageIsEmpty {
    return !_actionMessage || [_actionMessage isEqualToString:@""];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
