//
//  sheZhiVC.m
//  logRegister
//
//  Created by apple on 15-1-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "sheZhiVC.h"
#import "sheZhiVC.h"


#import "setUserInfoVC.h"
#import "setAboutVC.h"
#import "setHelpcenterVC.h"

#import "setPassWordVC.h"
#import "setScoreVC.h"
#import "logInVC.h"
#import "adviceVC.h"
@interface sheZhiVC ()

@end

@implementation sheZhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"设置");

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //_tableView.rowHeight=40;
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 15;
    }else
    {
        return 7.5;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7.5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==3) {
        return 1;
    }
    else
    {
        return 2;

    }

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        if (indexPath.row==0) {
             cell.textLabel.text=@"个人设置";
        }else
        {
             cell.textLabel.text=@"修改密码";

        }

    }
    else if (indexPath.section==3)
    {
        if (indexPath.row==0) {
//            cell.textLabel.text=@"修改密码";
//        }else
//        {
             cell.accessoryType=UITableViewCellAccessoryNone;

            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width,cell.contentView.frame.size.height)];
            label.text=@"注销账号";
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            label.font=[UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label];
            label.backgroundColor=APP_ClOUR;
        }

    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"积分规则";
        }else
        {
            cell.textLabel.text=@"帮助中心";
        }

    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0) {

            cell.textLabel.text=@"关于我们";
        }else{
            cell.textLabel.text=@"意见反馈";

        }

    }


    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            PUSH(setUserInfoVC)
        }else
        {
            PUSH(setPassWordVC)
            vc.whoPush = @"shezhi";

        }



    } else if (indexPath.section==3)
    {
        if (indexPath.row==0) {

            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"确定要注销当前账号？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];

        }

    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            PUSH(setScoreVC)
        }else
        {
            PUSH(setHelpcenterVC)
        }

    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
           PUSH(setAboutVC)
        }else{
            PUSH(adviceVC)
        }


    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {

    }else
    {
        [requestData cancelLonIn];
        logInVC*vc=[[logInVC alloc]init];
        if ([self.whoPush isEqualToString:@"manage"]) {
           // vc.whoPush=@"manage";
        }else
        {
            //vc.whoPush=@"center";

        }

        [self presentViewController:vc animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:NO];
        }];


        self.tabBarController.tabBar.hidden=YES;

    }
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}
-(void)backClick
{
    self.tabBarController.tabBar.hidden=YES;
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
