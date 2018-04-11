//
//  jpushVC.m
//  logRegister
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "jpushVC.h"

@interface jpushVC ()

@end

@implementation jpushVC


-(void)loadingView
{
    LOADING_REMOVE
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadingView) name:@"load" object:nil];

    TOP_VIEW(@"网页")
    NSLog(@"---%@",self.url);
    if ([self.whoPush isEqualToString:@"coup"]) {
        label.text=@"优惠详情";

    }
    if ([self.whoPush isEqualToString:@"noti"]) {
        label.text=@"通知详情";

    }


    UIWebView*web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    web.scalesPageToFit=YES;
    web.delegate=self;
    NSURL* url = [NSURL URLWithString:self.url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];
    [self.view addSubview:web];

    LOADING_VIEW

}
-(void)removeLoadView
{
    LOADING_REMOVE
    //ALERT(@"请求超时，请稍后重试")
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    LOADING_REMOVE

}
-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
