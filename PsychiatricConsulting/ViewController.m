//
//  ViewController.m
//  TianXinManor
//
//  Created by apple on 15/11/9.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "ViewController.h"
#import "homePage.h"
#import "scoreVC.h"
#import "personCenter.h"

#import "shopListVC.h"
#import "productCenterViewController.h"
//#import "storyVC.h"
#import "ShequViewController.h"
#import "shopCarVC.h"
#import "UIImage+GIF.h"
@interface ViewController ()
{
    UITabBarController*tabBarC;
    UIImageView *imageV;
    UIButton *cancle;
}
@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"districtId"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    SCREEN_WIDTH_AND_HEIGHT
    SCREEN




    tabBarC=[[UITabBarController alloc]init];

    productCenterViewController*vc1=[[productCenterViewController alloc]init];
    UINavigationController*nav1=[[UINavigationController alloc]initWithRootViewController:vc1];
    nav1.tabBarItem.title=@"分类";
    nav1.tabBarItem.image=[UIImage imageNamed:@"sy16"];



    homePage*vc3=[[homePage alloc]init];
    UINavigationController*nav3=[[UINavigationController alloc]initWithRootViewController:vc3];
    nav3.tabBarItem.title=@"首页";
    nav3.tabBarItem.image=[UIImage imageNamed:@"sh12"];
    shopCarVC*vc4=[[shopCarVC alloc]init];

    UINavigationController*nav4=[[UINavigationController alloc]initWithRootViewController:vc4];
    nav4.tabBarItem.title=@"购物车";
    nav4.tabBarItem.image=[UIImage imageNamed:@"sy11"];

    personCenter*vc5=[[personCenter alloc]init];
    UINavigationController*nav5=[[UINavigationController alloc]initWithRootViewController:vc5];
    nav5.tabBarItem.title=@"我的";
    nav5.tabBarItem.image=[UIImage imageNamed:@"sy12"];

    ShequViewController *shequ = [[ShequViewController alloc]init];
    UINavigationController *shequNV = [[UINavigationController alloc]initWithRootViewController:shequ];
    shequNV.tabBarItem.title = @"社区";
    shequNV.tabBarItem.image = [UIImage imageNamed:@"sy14"];


    tabBarC.viewControllers=@[nav1,shequNV,nav3,nav4,nav5];

    tabBarC.tabBar.tintColor=APP_ClOUR;


    imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];

    imageV.image = [UIImage sd_animatedGIFNamed:@"欢迎页4号"];
    [self.view addSubview:imageV];

    [self.view bringSubviewToFront:imageV];

    [NSTimer scheduledTimerWithTimeInterval:110 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];


    cancle = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.8, 20, 44, 44)];

    [cancle setTitle:@"跳过" forState:UIControlStateNormal];
    cancle.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [cancle addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancle];

}
-(void) cancleClick{
    [self removeLun];
    cancle.hidden = YES;
}
-(void)removeLun
{
    tabBarC.selectedIndex=2;
    [UIApplication sharedApplication].keyWindow.rootViewController=tabBarC;
    
    [imageV  removeFromSuperview];
    
}@end
