//
//  ViewController.m
//  CustomTabBar
//
//  Created by Jion on 2017/11/29.
//  Copyright © 2017年 Jion. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildDissBtn];
    
}

-(void)buildDissBtn{
    UIButton *dissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dissBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [dissBtn setTitle:@"x" forState:UIControlStateNormal];
    dissBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    [dissBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [dissBtn addTarget:self action:@selector(closePresent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dissBtn];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[btn(40)]" options:0 metrics:@{} views:@{@"btn":dissBtn}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[btn(30)]" options:0 metrics:@{} views:@{@"btn":dissBtn}]];
}

-(void)closePresent{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
