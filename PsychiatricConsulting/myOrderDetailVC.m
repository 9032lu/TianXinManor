//
//  myOrderDetailVC.m
//  PsychiatricConsulting
//
//  Created by apple on 15/9/22.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "myOrderDetailVC.h"
#import "transformTime.h"
#import "logInVC.h"
@interface myOrderDetailVC ()<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate>
{
    SCREEN_WIDTH_AND_HEIGHT
    UITableView *_tableView;
    NSDictionary         *_dataDict;

    UILabel *detailLab;
    float           _webH;
    CGFloat  imagY;

}
@end

@implementation myOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"活动详情");
    self.tabBarController.tabBar.hidden=YES;
    _webH = _width;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor = RGB(234, 234, 234);
    [self.view addSubview:_tableView];
    [self getData];

}
-(void)getData
{
    LOADVIEW
    NSString*url =[NSString stringWithFormat:@"%@/activity/detail.action?activityId=%@",BASE_URLL,self.appointmentId];
    [requestData  getData:url complete:^(NSDictionary *dic) {
        NSLog(@"dic======%@",url);
        LOADREMOVE
        _dataDict=[dic objectForKey:@"data"];
        [_tableView reloadData];
        
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return _width*0.23;
    }else if (indexPath.row ==1){

//        CGSize labSize = [self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:[self filterHTML:_dataDict[@"activityContent"]] WithFont:[UIFont systemFontOfSize:15]];
//   _dataDict[@"activityImage"]
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_dataDict[@"activityImage"]]]];
        float   w=image.size.width;
        float   hh=image.size.height;
        float HHHHH=0.0;
        if (image ==nil) {
            HHHHH=0.5*_width;
        }else{
            if (hh>w) {
                //            float  W=(_width*0.5)*image.size.width/image.size.height;
                HHHHH=0.5*_width;

            }else
            {
                HHHHH=_width*0.9*image.size.height/image.size.width;
            }

        }


        return _width*0.5+_webH + HHHHH;
    }else
        return 0.1;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    cell.selectionStyle=UITableViewCellSelectionStyleNone;




    if (indexPath.row==0) {
        UILabel*activityTitle=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width, _width*0.12)];
        activityTitle.text=_dataDict[@"activityTitle"];
        activityTitle.numberOfLines=0;
        activityTitle.textAlignment=NSTextAlignmentLeft;
        activityTitle.textColor=[UIColor blackColor];
        activityTitle.font=[UIFont boldSystemFontOfSize:17];
        [cell.contentView addSubview:activityTitle];

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        NSDate *date=[dateFormatter dateFromString:_dataDict[@"pubDate"]];
        NSDateFormatter *dateformatter1 =[[NSDateFormatter alloc]init];
        [dateformatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *datestring = [dateformatter1 stringFromDate:date];

//        NSLog(@"---%@",datestring);


        UILabel *timelab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.1, _width, _width*0.12)];
        timelab.text=datestring;
        timelab.textAlignment=NSTextAlignmentLeft;
        timelab.textColor=[UIColor lightGrayColor];
        timelab.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:timelab];

    }else if (indexPath.row==1){


        UILabel*startDate=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.02, _width, _width*0.08)];
        NSString *startSting = [_dataDict[@"startDate"] substringToIndex:16];
        if (_dataDict[@"startDate"]==nil || startSting.length ==0) {
            startSting = @" ";
        }
            startDate.text = [NSString stringWithFormat:@"开始时间：%@",startSting] ;

        startDate.numberOfLines=1;
        startDate.textAlignment=NSTextAlignmentLeft;
        startDate.textColor=[UIColor darkGrayColor];
        startDate.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:startDate];

        UILabel*endDate=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.07+3, _width, _width*0.08)];
        NSString *endSting = [_dataDict[@"endDate"] substringToIndex:16];
        if (_dataDict[@"endDate"]==nil || endSting.length ==0) {
            endSting= @" ";
        }
            endDate.text= [NSString stringWithFormat:@"结束时间：%@",endSting];


        endDate.numberOfLines=1;
        endDate.textAlignment=NSTextAlignmentLeft;
        endDate.textColor=[UIColor darkGrayColor];
        endDate.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:endDate];

        UILabel*activityAddress=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.12+6, _width, _width*0.08)];

        NSString *adds =_dataDict[@"activityAddress"];

        if (_dataDict[@"activityAddress"]==nil || adds.length ==0) {
            activityAddress.text = @"举办地点：";
        }else{
            activityAddress.text= [NSString stringWithFormat:@"举办地点：%@",_dataDict[@"activityAddress"]] ;

        }

        activityAddress.numberOfLines=1;
        activityAddress.textAlignment=NSTextAlignmentLeft;
        activityAddress.textColor=[UIColor darkGrayColor];
        activityAddress.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:activityAddress];

        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.25, _width, _width*0.08)];
        lab.textColor=[UIColor darkGrayColor];
        lab.text=@"活动介绍：";
        lab.font=[UIFont systemFontOfSize:15];
        [cell.contentView addSubview:lab];

        UIImageView*doct=[[UIImageView alloc]init];
            doct.frame=CGRectMake(_width*0.05, _width*0.35, _width*0.9, _width*0.5);
//        doct.center= CGPointMake(_width/2, _width*0.6);

           [doct sd_setImageWithURL:[NSURL URLWithString:_dataDict[@"activityImage"]] placeholderImage:[UIImage imageNamed:@"chang"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
               if (image==nil) {
                   image=[UIImage imageNamed:@"chang"];
               }

               float   w=image.size.width;
               float   hh=image.size.height;
               
               if (hh>w) {
                   float  W=(_width*0.5)*image.size.width/image.size.height;
                   doct.frame=CGRectMake(_width*0.05, _width*0.35, W, _width*0.5);
               }else
               {
                   float  H=_width*0.9*image.size.height/image.size.width;
                   doct.frame=CGRectMake(_width*0.05, _width*0.35, _width*0.9, H);
               }


                }];
        [cell.contentView addSubview:doct];

//        detailLab = [[UILabel alloc]init];
//        detailLab.font=[UIFont systemFontOfSize:15];
//        detailLab.textColor=[UIColor darkGrayColor];
//        detailLab.text= [self filterHTML:_dataDict[@"activityContent"]];
//
//        CGSize labSize = [self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:detailLab.text WithFont:[UIFont systemFontOfSize:15]];
//        detailLab.frame=CGRectMake(_width*0.05, doct.frame.origin.y+doct.frame.size.height+10, _width*0.9, labSize.height);
//        [cell.contentView addSubview:detailLab];
        imagY = doct.frame.origin.y+doct.frame.size.height+10;
        UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, imagY, _width, _webH)];
        [webView loadHTMLString:_dataDict[@"activityContent"] baseURL:nil];
        webView.scalesPageToFit=NO;
        webView.delegate=self;
        webView.opaque = NO;
        webView.userInteractionEnabled=NO;
        webView.scrollView.scrollEnabled=NO;
        webView.scrollView.showsHorizontalScrollIndicator = NO;
        webView.scrollView.showsVerticalScrollIndicator = NO;
        webView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:webView];



        UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.65, _height-_width*0.12,_width*0.33, _width*0.12)];
        backbtn.frame = CGRectMake(0, _height-44, _width, 44);
        backbtn.backgroundColor =APP_ClOUR;
        [backbtn setTitle:@"我要预约" forState:UIControlStateNormal];
        backbtn.titleLabel.font =[UIFont boldSystemFontOfSize:18];
        [backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        backbtn.tag = [_dataDict[@"activityId"] intValue] ;
        [backbtn addTarget:self action:@selector(cancleBtn:) forControlEvents:UIControlEventTouchUpInside];
        //        backbtn.layer.cornerRadius = _width*0.01;
        [self.view addSubview:backbtn];

        if ([self.whoPush isEqualToString:@"wode"]||self.IsEnd==YES) {
            backbtn.hidden = YES;
          }


    }


    //    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.75, _width*0.17, _width*0.23, 44)];
    //    cancleBtn.backgroundColor =[UIColor redColor];
    //    [cell.contentView addSubview:cancleBtn];



    return cell;

}
-(void)cancleBtn:(UIButton*)sender{

    if (USERID!=nil) {

        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"确定要预约此活动？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];

//        NSString *url = [NSString stringWithFormat:@"%@/activity/ add.action?activityId=%ld&userId=%@",BASE_URLL,(long)sender.tag,USERID];
//        [requestData getData:url complete:^(NSDictionary *dic) {
//
//            MISSINGVIEW
////            missing_v.labelFrame = *(CGRectMake(_width/5, _height*0.5, _width*0.6, 50));
////            missing_v.label.frame = CGRectMake(_width/5, _height*0.5, _width*0.6, 50);
//
//            missing_v.tishi=dic[@"info"];


//        }];
    }else{
        MISSINGVIEW

        missing_v.tishi=@"您还没有登陆！";

    }
        



    NSLog(@"我要预约");
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {

    }else
    {

       
        NSString *url = [NSString stringWithFormat:@"%@/activity/ add.action?activityId=%d&userId=%@",BASE_URLL,[_dataDict[@"activityId"] intValue],USERID];
        NSLog(@"++++%@",url);
        [requestData getData:url complete:^(NSDictionary *dic) {

            MISSINGVIEW
            //            missing_v.labelFrame = *(CGRectMake(_width/5, _height*0.5, _width*0.6, 50));
            //            missing_v.label.frame = CGRectMake(_width/5, _height*0.5, _width*0.6, 50);

            missing_v.tishi=dic[@"info"];
            
            
        }];

        
    }
}

-(void)backClick{

    POP
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    CGFloat documentHeight =  [[webView stringByEvaluatingJavaScriptFromString: @"document.documentElement.scrollHeight"] floatValue];
    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    CGFloat documentWidht = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetWidth"] floatValue];

    documentHeight = documentHeight/documentWidht*_width;

    _webH=(float)documentHeight+20;
    double delay_s=0.2;
    dispatch_time_t poptime=dispatch_time(DISPATCH_TIME_NOW, delay_s*NSEC_PER_SEC);
    dispatch_after(poptime, dispatch_get_main_queue(), ^{
        webView.frame=CGRectMake(0, imagY, _width, _webH);

        [_tableView beginUpdates];
        [_tableView endUpdates];
    });
}

#pragma HTML
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
//    NSString * regEx = @"&nbsp;";
//    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
//
//    NSString * regEx1 = @"作者";
//    html = [html stringByReplacingOccurrencesOfString:regEx1 withString:@" 作者"];
//    NSString * regEx2 = @"出处";
//    html = [html stringByReplacingOccurrencesOfString:regEx2 withString:@" 出处"];

    return html;
}

-(CGSize)boundWithSize:(CGSize)size  WithString:(NSString*)str  WithFont:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};

    CGSize retSize = [str boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    return retSize;
}

@end
