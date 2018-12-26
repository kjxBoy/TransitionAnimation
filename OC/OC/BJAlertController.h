//
//  BJAlertController.h
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, BJAlertControllerStyle) {
    // 我的 - 添加爱车
    BJAlertControllerAddFavourateCar = 10
    
};

NS_ASSUME_NONNULL_BEGIN

@interface BJAlertController : UIViewController

//UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"12345678" preferredStyle:UIAlertControllerStyleAlert];


+ (instancetype)alertControllerWithStyle:(BJAlertControllerStyle)style;

@end

NS_ASSUME_NONNULL_END
