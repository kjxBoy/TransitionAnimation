//
//  ViewController.m
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"
#import "BJAlertController.h"
#import "BJAlertAction.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)modelNewViewController:(UIButton *)sender {
    

    
    BJAlertController *alertViewController = [BJAlertController alertControllerWithTitle:@"标题" message:@"这里是一段描述，支持换行，可随意输入" withAlertStyle:BJAlertControllerAddFavourateCar];
    
    BJAlertAction *sureAction = [BJAlertAction actionWithTitle:@"确认" style:BJAlertActionStyleDefault handler:^(BJAlertAction * _Nonnull action) {
        NSLog(@"sure");
    }];
    BJAlertAction *cancelAction = [BJAlertAction actionWithTitle:@"取消" style:BJAlertActionStyleCancel handler:nil];
    
    [alertViewController addAction:sureAction];
    [alertViewController addAction:cancelAction];
    
    [self presentViewController:alertViewController animated:YES completion:nil];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"12345678" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"123" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:sureAction];
    
    [self presentViewController:alert animated:false completion:nil];
}

@end
