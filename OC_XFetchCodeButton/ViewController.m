//
//  ViewController.m
//  OC_XFetchCodeButton
//
//  Created by 王雄皓 on 2017/4/19.
//  Copyright © 2017年 王雄皓. All rights reserved.
//

#import "ViewController.h"
#import "XFetchCodeButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XFetchCodeButton * button = [[XFetchCodeButton alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    
    [button doneSend:^{
        NSLog(@"button click");
    }];
    
    XFetchCodeButton * button2 = [[XFetchCodeButton alloc] initWithFrame:CGRectMake(20, 200, 100, 50)];
    button2.backgroundColor = [UIColor purpleColor];
    button2.disabledColor = [UIColor whiteColor];
    button2.normalTitle = @"Fetch Code";
    button2.normalTintColor = [UIColor grayColor];
    [button2 addTarget:self action:@selector(send) forEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)send {
    NSLog(@"button2 click");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
