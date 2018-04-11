//
//  postOnWayVC.m
//  logRegister
//
//  Created by apple on 15-1-20.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "postOnWayVC.h"

@interface postOnWayVC ()

@end

@implementation postOnWayVC


- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"查看物流");
    //http://m.kuaidi100.com/index_all.html?type=shentong&postid=968664596520
    _scrollView=[[UIScrollView  alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];

    [self.view addSubview:_scrollView];
//    NSLog(@"%@",self.expressNo);
    //ALERT([self.dic objectForKey:@"info"]);

    NSDictionary*dic=[self.dic objectForKey:@"data"];
//    NSString*expressTypeName=[dic objectForKey:@"expressTypeName"];
    NSString*expressNo=[dic objectForKey:@"expressNo"];
    NSString*expressTypeCode=[dic objectForKey:@"expressTypeCode"];

    NSString*url=[NSString stringWithFormat:@"http://m.kuaidi100.com/index_all.html?type=%@&postid=%@",expressTypeCode,expressNo];

    NSLog(@"===%@",url);
    UIWebView*web=[[UIWebView alloc]initWithFrame:CGRectMake(0,0, _width, _height)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    web.scalesPageToFit=YES;
    web.scrollView.scrollEnabled=YES;
    web.delegate=self;

    [_scrollView addSubview:web];
    


    //    LEFT_LABEL(la1, @"物流名称:", 20, 30, 15);
//    RIGHT_LABEL(la11, [dic objectForKey:@"expressTypeName"], 20, 30, 15);
//    LEFT_LABEL(la12, @"物流编号:", 50, 30, 15);
//    RIGHT_LABEL(la22, [dic objectForKey:@"expressNo"], 50, 30, 15);
//    LEFT_LABEL(la13, @"快递号:", 80, 30, 15);
//    RIGHT_LABEL(la33, [dic objectForKey:@"expressTypeCode"], 80, 30, 15);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{


}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
