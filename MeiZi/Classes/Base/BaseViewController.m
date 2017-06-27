//
//  BaseViewController.m
//  MeiZi
//
//  Created by afarsoft on 2017/6/27.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)customNavigationBar:(NSString *)title hasLeft:(BOOL)hasLeft{
    self.title = title;
    if (hasLeft) {
        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        //left.backgroundColor = [UIColor redColor];
        left.frame = CGRectMake(0, 0, 25, 25);
        [left setBackgroundImage:[UIImage imageNamed:@"navcleft"] forState:UIControlStateNormal];
        [left addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:left];
    }
}
- (void)backClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
