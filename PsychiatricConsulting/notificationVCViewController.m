//
//  notificationVCViewController.m
//  logRegister
//
//  Created by apple on 15-4-21.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "notificationVCViewController.h"
#import "danli.h"
#import "webViewVC.h"
@interface notificationVCViewController ()

@end

@implementation notificationVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   TOP_VIEW(@"消息")

    danli*myapp=[danli shareClient];
    myapp.isread=YES;


    [UIApplication sharedApplication].applicationIconBadgeNumber=0;

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
 //   _tableView.backgroundColor=[UIColor whiteColor];
    _tableView.rowHeight=50;
    _tableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_tableView];


}


-(void)getdata
{
    LOADVIEW
    UIImageView*imagev=(UIImageView*)[_tableView viewWithTag:22222];
    UILabel*tishila=(UILabel*)[_tableView viewWithTag:2222];
    [imagev removeFromSuperview];
    [tishila removeFromSuperview];
    

    NSString*url_;
//    if ([self.whoPush isEqualToString:@"maijia"]) {
//        url_=NOTIFICATION_URL(@"1");
//    }else
//    {
        url_=NOTIFICATION_URL(@"0");
//    }

    NSLog(@"%@",url_);

    [requestData getData:url_ complete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        LOADREMOVE

        id array=[dic objectForKey:@"data"];
        NSArray*nullA=@[];
        if (array==nil||array==nullA) {
            _dataArray=@[];
        }else
        {
            _dataArray=(NSArray*)array;
        }
        [_tableView reloadData];



        if (_dataArray.count==0) {
            //NSLog(@"%@",_dataArray);
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有消息哦";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];
            tanhao.tag=22222;
            tishi.tag=2222;
            
        }
        



    }];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 30   ;
    }else
    {
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;


    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
    NSString*noticeTitle=[dic objectForKey:@"noticeTitle"];
    NSString*notiTime=[dic objectForKey:@"noticeTime"];

    cell.textLabel.text=noticeTitle;
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    cell.detailTextLabel.text=notiTime;
    cell.detailTextLabel.textAlignment=NSTextAlignmentRight;
    cell.detailTextLabel.textColor=[UIColor grayColor];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:12];

//    UIView*grayline=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05, 49, _width, 1)];
//    grayline.backgroundColor=RGB(234, 234, 234);
//    [cell.contentView addSubview:grayline];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary*dic=[_dataArray objectAtIndex:indexPath.section];
    NSString*noticeId=[dic objectForKey:@"noticeId"];
    NSString*urll=NOTIFICATION_DETAIL_URL(noticeId);
    PUSH(webViewVC)
    vc.whoPush=@"noti";
    vc.url=urll;


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self getdata];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
