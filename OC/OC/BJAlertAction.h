//
//  BJAlertAction.h
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BJAlertActionStyle) {
    BJAlertActionStyleDefault = 0,
    BJAlertActionStyleCancel,
    BJAlertActionStyleDestructive
};


NS_ASSUME_NONNULL_BEGIN

@interface BJAlertAction : NSObject

typedef void(^__nullable AlertActionBlock)(BJAlertAction *);

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(BJAlertActionStyle)style handler:(void (^ __nullable)(BJAlertAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) BJAlertActionStyle style;
@property (nonatomic, copy, readonly) AlertActionBlock actionBlock;


@end

NS_ASSUME_NONNULL_END
