//
//  BJAlertAction.m
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "BJAlertAction.h"

@interface BJAlertAction ()
@property (nullable, nonatomic) NSString *title;
@property (nonatomic) BJAlertActionStyle style;
@property (nonatomic, copy) AlertActionBlock actionBlock;

@end

@implementation BJAlertAction


+ (instancetype)actionWithTitle:(nullable NSString *)title style:(BJAlertActionStyle)style handler:(void (^ __nullable)(BJAlertAction *action))handler {
    BJAlertAction *action = [[BJAlertAction alloc] init];
    
    action.title = title;
    action.style = style;
    action.actionBlock = handler;
    
    return action;
}


@end
