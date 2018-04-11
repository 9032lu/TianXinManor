//
//  webViewVC.m
//  logRegister
//
//  Created by apple on 14-12-31.
//  Copyright (c) 2014年 LiZhao. All rights reserved.
//

#import "webViewVC.h"
#import "define.h"
#import "myButton.h"
@interface webViewVC ()
{
    myButton*rightUpBtnBack;
}

@end

@implementation webViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN

    if ([self.whoPush isEqualToString:@"productDetail"]) {
        TOP_VIEW(@"商品详情")
    }else if([self.whoPush isEqualToString:@"gongxu"])
    {
        TOP_VIEW(@"供需详情")

    }else if([self.whoPush isEqualToString:@"news"])
    {
        TOP_VIEW(@"新闻详情")

    }else if([self.whoPush isEqualToString:@"Privilege"] ||[self.whoPush isEqualToString:@"center"])
    {
         TOP_VIEW(@"会员特权")
//        topView.backgroundColor =[UIColor redColor];
    }else if([self.whoPush isEqualToString:@"regiser"])

    {
        TOP_VIEW(@"注册协议")
    }else if([self.whoPush isEqualToString:@"company"]){
        TOP_VIEW(@"企业简介")
        UIButton*rightUpBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        rightUpBtn.frame=CGRectMake(_width*0.85, 28,25, 20);

        [rightUpBtn setBackgroundImage:[UIImage imageNamed:@"sy1"] forState:UIControlStateNormal];
        [topView addSubview:rightUpBtn];
        
        rightUpBtnBack=[myButton buttonWithType:UIButtonTypeCustom];
        rightUpBtnBack.frame=CGRectMake(_width*0.85, 0,_width*0.8, 64);
        [rightUpBtnBack addTarget:self action:@selector(rightUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightUpBtnBack.isClicked=NO;
        [topView addSubview:rightUpBtnBack];

        [self getdata];

    }
else
    {
        TOP_VIEW(@"详情")
    }

    web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    web.scalesPageToFit=YES;
    web.delegate=self;
    [self.view addSubview:web];


    [self loadWebData];

}
-(void)loadWebData{

      NSURL* url = [NSURL URLWithString:_url];
    NSLog(@"url======%@",url);
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [web loadRequest:request];

    viewh=[[myView alloc]initWithFrame:self.view.frame];
    viewh.backgroundColor=[UIColor clearColor];
    [self.view addSubview:viewh];
    viewh.remind_L=@"\t正在加载";
    

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

        LOADREMOVE

    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
    //webView.frame=CGRectMake(0, 0, _width, documentHeight);

    NSLog(@"%f",documentHeight);


    
}
-(void)rightUpBtnClick:(myButton*)button
{

    if (button.isClicked) {
        button.isClicked=NO;
        [UIView animateWithDuration:0.5 animations:^{

            for (UIView *view in _downwardView.subviews) {
                [view removeFromSuperview];
            }
            [_downwardView removeFromSuperview];

        }];

        return;
    }else
    {
        button.isClicked=YES;

        [self downwaListView];
        
    }
    
}
-(void)downwaListView
{

        [UIView animateWithDuration:0.5 animations:^{

    _downwardView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, 1)];
    _downwardView.scrollEnabled=YES;
    _downwardView.backgroundColor=RGB(247, 247, 247);
    _downwardView.bounces=NO;
    _downwardView.delegate =self;
    _downwardView.dataSource = self;
    _downwardView.frame=CGRectMake(0, 64, _width,_height-64);
    _downwardView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_downwardView];

        } completion:^(BOOL finished) {
    
        }];


    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 45, _width, 1)];
    line.backgroundColor = RGB(234, 234, 234);
    [cell addSubview:line];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [_dataArray[indexPath.row] objectForKey:@"typeName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (rightUpBtnBack.isClicked ==YES) {
        rightUpBtnBack.isClicked=NO;
    }else{
        rightUpBtnBack.isClicked = YES;
    }

//    NSLog(@"%@",[self.view.subviews[0] subviews]);
    for (UILabel *lab in [self.view.subviews[0] subviews]) {

        if ([lab isKindOfClass:[UILabel class]]) {
            lab.text =[_dataArray[indexPath.row] objectForKey:@"typeName"];
        }
    }
    NSString *typeId=[_dataArray[indexPath.row] objectForKey:@"typeId"];
    _url=[NSString stringWithFormat:@"%@/information/get.action?typeId=%@",BASE_URLL,typeId];
    [self loadWebData];
    [_downwardView removeFromSuperview];
}
-(void)getdata{
    UIImageView*iv=(UIImageView*)[_downwardView viewWithTag:22222];
    UILabel*la=(UILabel*)[_downwardView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    NSString*url;



    url=[NSString stringWithFormat:@"%@/infoType/list.action",BASE_URLL];
//    LOADVIEW

    //NSLog(@"%@",url);
    [requestData getData:url complete:^(NSDictionary *dic) {
        NSLog(@"**************%@",url);
//        LOADREMOVE
        id dd=[dic objectForKey:@"data"];
        if (dd==[NSNull null]) {
            dd=@[];
        }
        _dataArray=dd;
        [_downwardView reloadData];
        NSArray*nullA=@[];
        if (_dataArray.count==0||_dataArray==nullA||_dataArray==nil) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-160)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];

            [_downwardView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-160)/2+60, _width, 20)];
            tishi.text=@"暂无相关信息";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_downwardView addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;
        }
    }];
    // NSLog(@"%@",ADV_LIST_URL(@"1"));
        [requestData getData:ADV_LIST_URL(@"1") complete:^(NSDictionary *dic) {
           // NSLog(@"%@",dic);
//            _advistArray=[dic objectForKey:@"data"];
//            [_tableView reloadData];
        }];

}
-(void)backClick
{
    //self.tabBarController.tabBar.hidden=NO;

    if ([self.whoPush isEqualToString:@"regiser"]||[self.whoPush isEqualToString:@"center"]) {
        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }else
        POP

}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
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
