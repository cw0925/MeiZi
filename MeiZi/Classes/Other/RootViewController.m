//
//  RootViewController.m
//  121Store
//
//  Created by qf on 15/12/14.
//  Copyright © 2015年 cw. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *arrM = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Controller.plist" ofType:nil];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dic in arr) {
        NSString *icon = dic[@"icon"];
        NSString *iconSelected = dic[@"pressIcon"];
        NSString *title = dic[@"title"];
        NSString *controller = dic[@"viewController"];
        Class class = NSClassFromString(controller);
        UIViewController *viewController = [[class alloc]init];
        UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:viewController];
        navc.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:icon] selectedImage:[[UIImage imageNamed:iconSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        //点击时更改字体颜色
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:42/255.0 green:104/255.0 blue:168/255.0 alpha:0.8],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [arrM addObject:navc];
    }
    self.viewControllers = arrM;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
