//
//  GirlInfoViewController.m
//  MeiZi
//
//  Created by afarsoft on 2017/6/27.
//  Copyright © 2017年 afarsoft. All rights reserved.
//

#import "GirlInfoViewController.h"
#import <WebKit/WebKit.h>

@interface GirlInfoViewController ()

@end

@implementation GirlInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar:_navcTitle hasLeft:YES];
    [self initUI];
}
- (void)initUI{
    WKWebView *webView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.view addSubview:webView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
