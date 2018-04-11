
//
//  homePage.m
//  PsychiatricConsulting
//
//  Created by apple on 15/9/18.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "homePage.h"
#import "productCenterViewController.h"
#import "activeListVC.h"
#import "ShequViewController.h"
#import "scoreVC.h"
#import "newsVC.h"
#import "chargeListVC.h"
#import "personCenter.h"
#import "webViewVC.h"
@interface homePage ()
{
    SCREEN_WIDTH_AND_HEIGHT
}
@end

@implementation homePage


-(void)viewWillDisappear:(BOOL)animated

{
    [super viewWillDisappear:animated];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    self.navigationController.navigationBarHidden=YES;
    self.tabBarController.tabBar.hidden =YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    UIImageView *backimg = [[UIImageView alloc]initWithFrame:self.view.frame];
    backimg.image =[UIImage imageNamed:@"首页22"];
    [self.view addSubview:backimg];

    NSArray *backImgArr = [NSArray arrayWithObjects:@"走进庄园",@"积分乐园",@"会员特权",@"新闻中心",@"登录",@"商品中心",@"个人中心",@"社区",@"优惠券", nil];

    NSArray *picArray = [NSArray arrayWithObjects:@"home1",@"home3",@"home4",@"home6",@"home8",@"home2",@"home5",@"home7",@"home9", nil];
    CGFloat w = (_width-40)/3;
    for (int i =0; i <5; i ++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];
        UIImageView *imageview= [[UIImageView alloc]init];
        UILabel *lab = [[UILabel alloc]init];
        lab.bounds = CGRectMake(0, 0, _width*0.5, _width*0.156);
        lab.text = backImgArr[i];


        button.tag =i;
        [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];

        UIImageView *butonImg= [[UIImageView alloc]init];
        butonImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",backImgArr[i]]];
        [button addSubview:butonImg];

        imageview.image= [UIImage imageNamed:picArray[i]];
        [button addSubview: imageview];

        lab.font = [UIFont boldSystemFontOfSize:20];
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        [button addSubview:lab];
        


        if (i==0) {
            button.frame = CGRectMake(10, 44+i*(_height*0.197+10), w*2+10, _height*0.197);
            butonImg.frame =CGRectMake(0, 0, w*2+10, _height*0.197);

            imageview.frame = CGRectMake(0, 0, w*2+10, _height*0.197);
            lab.center =CGPointMake((w*2+10)/4*3, _height*0.197/2);
            lab.hidden = YES;


        }else if (i==1) {
            button.frame = CGRectMake(10, 44+(_height*0.197+10), w, _height*0.197);
            butonImg.frame =CGRectMake(0, 0, w, _height*0.197);

            imageview.center= CGPointMake(w/2, _height*0.197/3);
            imageview.bounds= CGRectMake(0, 0,_width*0.1875, _width*0.1875);

            lab.center= CGPointMake(w/2, _height*0.197/4*3);


        }else if(i ==2){
            button.frame = CGRectMake(w+20, 44+(_height*0.197+10), w, _height*0.197);
            butonImg.frame =CGRectMake(0, 0, w, _height*0.197);

            imageview.center= CGPointMake(w/2, _height*0.197/3);
            imageview.bounds= CGRectMake(0, 0,_width*0.1875, _width*0.1875);

            lab.center= CGPointMake(w/2, _height*0.197/4*3);


        }else {
            button.frame = CGRectMake(10, 44+(i-1)*(_height*0.197+10), w*2+10, _height*0.197);
            butonImg.frame =CGRectMake(0, 0, w*2+10, _height*0.197);

            imageview.center= CGPointMake((w*2+10)/4, _height*0.197/2);
            imageview.bounds= CGRectMake(0, 0,_width*0.1875, _width*0.1875);

            lab.center =CGPointMake((w*2+10)/4*3, _height*0.197/2);
            if (i==4) {
                lab.text = @"活动专区";

            }

        }
           }

    for (int i = 5; i <9; i ++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeSystem];

        button.frame = CGRectMake(20+w*2+10, 44+(i-5)*(_height*0.197+10), w, _height*0.197);
        button.tag=i;

        [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        UIImageView *butonImg= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w, _height*0.197)];
        butonImg.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",backImgArr[i]]];
        [button addSubview:butonImg];


        UIImageView *imageview= [[UIImageView alloc]init];
        imageview.bounds= CGRectMake(0, 0, 60, 60);
        imageview.center= CGPointMake(w/2, _height*0.197/3);
        imageview.image= [UIImage imageNamed:picArray[i]];
        [button addSubview: imageview];

        UILabel *lab = [[UILabel alloc]init];
        lab.bounds = CGRectMake(0, 0, _width*0.5, 50);
        lab.center= CGPointMake(w/2, _height*0.197/4*3);
        lab.font = [UIFont boldSystemFontOfSize:18];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.textColor=[UIColor whiteColor];
        lab.text = backImgArr[i];
        [button addSubview:lab];

    }



}

-(void)buttonclick:(UIButton *)sender{

    switch (sender.tag) {
        case 0:{
            PUSH(webViewVC)//企业简介
            vc.whoPush= @"company";
            vc.url=[NSString stringWithFormat:@"%@/information/get.action?typeId=1",BASE_URLL];
        }

            break;
        case 1:{
            PUSH(scoreVC)//积分乐园
        }
            break;
        case 2:{
            PUSH(webViewVC) //会员特权
            vc.whoPush= @"Privilege";
            vc.url=[NSString stringWithFormat:@"%@/setUp/memberPrivileges.action",BASE_URLL];
        }

            break;
        case 3:{
            PUSH(newsVC)//咨询中心
        }
            break;
        case 4:{
            PUSH(activeListVC)//活动中心
        }
            break;
        case 5:{
            PUSH(productCenterViewController)//产品中心
        }
            break;
        case 6:{
            PUSH(personCenter)//个人中心
        }
            break;
        case 7:{
            PUSH(ShequViewController)//社区
        }
            break;
        case 8:{
            PUSH(chargeListVC)//优惠券
            vc.whoPush =@"shouye";
        }
            break;


        default:
            break;
    }
    NSLog(@"---%ld",(long)sender.tag);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
