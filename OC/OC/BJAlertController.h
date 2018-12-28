//
//  BJAlertController.h
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BJAlertAction.h"



/**
 扩展属性，后续有新的样式可通过style进行判断
 */
typedef NS_ENUM(NSInteger, BJAlertControllerStyle) {
    // 我的 - 添加爱车
    BJAlertControllerStyleAlert = 1
    
};

typedef void(^Block)(UIButton *button);

NS_ASSUME_NONNULL_BEGIN

@interface BJAlertController : UIViewController

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message withAlertStyle:(BJAlertControllerStyle)style;

- (void)addAction:(BJAlertAction *)action;


@end

NS_ASSUME_NONNULL_END
