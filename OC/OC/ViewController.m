//
//  ViewController.m
//  OC
//
//  Created by yiche on 2018/12/26.
//  Copyright © 2018 apple. All rights reserved.
//

#import "ViewController.h"
#import "BJAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (IBAction)modelNewViewController:(UIButton *)sender {
    
    BJAlertController *alertViewController = [BJAlertController alertControllerWithStyle:BJAlertControllerAddFavourateCar];
    [self presentViewController:alertViewController animated:YES completion:nil];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"12345678" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:true completion:nil];
}

@end
