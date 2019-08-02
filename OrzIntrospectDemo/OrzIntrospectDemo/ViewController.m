//
//  ViewController.m
//  OrzIntrospectDemo
//
//  Created by wangzhizhou on 2019/7/29.
//  Copyright © 2019 wangzhizhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor greenColor];
    label.text = @"I am code created";
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}


@end
