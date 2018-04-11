//
//  myOrderVC.m
//  PsychiatricConsulting
//
//  Created by apple on 15-5-7.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "myOrderVC.h"
#import "myOrderDetailVC.h"
#include "transformTime.h"
@interface myOrderVC ()

@end

@implementation myOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"我的预约活动")

//    self.view.backgroundColor = RGB(234, 234, 234);
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces =NO;
    _tableView.backgroundColor = RGB(234, 234, 234);
    [self.view addSubview:_tableView];

    [self getData];

}
-(void)getData
{


    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];

    NSString *url = [NSString stringWithFormat:@"%@?userId=%@",MY_YUYUE,USERID];
    [requestData  getData:url complete:^(NSDictionary *dic) {
        _dataArray=[dic objectForKey:@"data"];
        NSLog(@"--我的huodong---%@",url);
        if (_dataArray.count==0||_dataArray==nil) {

            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有预约!";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

            tanhao.tag=22222;
            tishi.tag=222222;

        }

        [_tableView reloadData];

    }];


}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _width*0.31;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[UIView new];
    view.backgroundColor =RGB(234, 234, 234);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];

//    NSString*pro_image=[dic objectForKey:@"productImage"];
//    NSString*activityTitle=[dic objectForKey:@"activityTitle"];
//    NSString*startDate=[dic objectForKey:@"startDate"];
//    NSString*endDate=[dic objectForKey:@"endDate"];
//    NSString*activityAddress=[dic objectForKey:@"activityAddress"];



    cell.selectionStyle=UITableViewCellSelectionStyleNone;

//    UIImageView*doct=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.03, _width*0.25, _width*0.25)];
//    [doct sd_setImageWithURL:[NSURL URLWithString:pro_image] placeholderImage:[UIImage imageNamed:@"doctor"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//    }];

//    doct.image=[UIImage imageNamed:@"doctor"];
//    doct.clipsToBounds=YES;
//    doct.layer.cornerRadius=_width*0.125;
//    [cell.contentView addSubview:doct];
//

    UILabel*activityTitle=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.53, _width*0.12)];
    activityTitle.text=dic[@"activityTitle"];
    activityTitle.numberOfLines=0;
    activityTitle.textAlignment=NSTextAlignmentLeft;
    activityTitle.textColor=[UIColor darkGrayColor];
    activityTitle.font=[UIFont boldSystemFontOfSize:16];
    [cell.contentView addSubview:activityTitle];


    UILabel*startDate=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.09, _width, _width*0.08)];


    NSString *startStr=dic[@"startDate"];
    NSString *endStr=dic[@"endDate"];


    startDate.text = [NSString stringWithFormat:@"开始时间：%@",[startStr substringToIndex:19]] ;
    startDate.numberOfLines=1;
    startDate.textAlignment=NSTextAlignmentLeft;
    startDate.textColor=[UIColor grayColor];
    startDate.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:startDate];

    UILabel*endDate=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.15, _width, _width*0.08)];
    endDate.text= [NSString stringWithFormat:@"结束时间：%@",[endStr substringToIndex:19]];
    endDate.numberOfLines=1;
    endDate.textAlignment=NSTextAlignmentLeft;
    endDate.textColor=[UIColor grayColor];
    endDate.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:endDate];

    UILabel*activityAddress=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, _width*0.21, _width, _width*0.08)];
    activityAddress.text= [NSString stringWithFormat:@"举办地点：%@",dic[@"activityAddress"]] ;
    activityAddress.numberOfLines=1;
    activityAddress.textAlignment=NSTextAlignmentLeft;
    activityAddress.textColor=[UIColor grayColor];
    activityAddress.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:activityAddress];

//    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.75, _width*0.17, _width*0.23, 44)];
//    cancleBtn.backgroundColor =[UIColor redColor];
//    [cell.contentView addSubview:cancleBtn];
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.77, _width*0.19, _width*0.2, _width*0.08)];
       backbtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
    [backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    backbtn.tag = indexPath.row;
    backbtn.layer.cornerRadius = _width*0.01;
    [cell.contentView addSubview:backbtn];

    NSDate *today = [NSDate date];    //得到当前时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    NSDate *endDate_S = [dateFormatter dateFromString:endStr];

    CGFloat Isend = [endDate_S timeIntervalSinceDate:today];

    if (Isend>0) {
        backbtn.backgroundColor =APP_ClOUR;
        [backbtn setTitle:@"取消" forState:UIControlStateNormal];

        [backbtn addTarget:self action:@selector(cancleBtn:) forControlEvents:UIControlEventTouchUpInside];

    }else{
        backbtn.backgroundColor =RGB(234, 234, 234);
        [backbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        [backbtn setTitle:@"已过期" forState:UIControlStateNormal];

    }

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.row];
    NSString*pro_id=[dic objectForKey:@"activityId"];
    PUSH(myOrderDetailVC)
    vc.appointmentId=pro_id;
    vc.whoPush = @"wode";


    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)backClick
{
    POP
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cancleBtn:(UIButton*)sender{

   oppoint= [_dataArray[sender.tag] objectForKey:@"appointmentId"];

    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"你确定要取消该活动吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];




}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex==1) {
        NSString *url = [NSString stringWithFormat:@"%@/activity/del.action?appointmentId=%@",BASE_URLL,oppoint];
        NSLog( @"删除！！！====%@",url);

        [requestData getData:url complete:^(NSDictionary *dic) {
            [self getData];
        }];

    }else{

    }

}

@end
