//
//  myAdressVC.m
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "myAdressVC.h"
#import "define.h"
#import "addAdressVC.h"
#import "alterAddressVC.h"

#import "addressCell.h"
#import "citySelectVC.h"
@interface myAdressVC ()

@end

@implementation myAdressVC
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN

    self.view.backgroundColor=[UIColor grayColor];
    TOP_VIEW(@"收货地址")

    UIButton*addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    addBtn.frame=CGRectMake(_width*0.9, 32, 15, 15);
    [topView addSubview:addBtn];

    UIButton*addBg=[UIButton buttonWithType:UIButtonTypeCustom];
    addBg.frame=CGRectMake(_width*0.85, 20, _width*0.15 ,44);
    [addBg addTarget:self action:@selector(addAdress) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:addBg];


    _adressArray=[[NSMutableArray alloc]initWithCapacity:0];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.bounces=YES;
    _tableView.separatorColor=[UIColor clearColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=115;
    [self.view addSubview:_tableView];


    //[self getdata];


    _alpaView=[[UIView alloc]initWithFrame:CGRectMake(0, -64, _width,64)];
    _alpaView.backgroundColor=[UIColor darkGrayColor];
    _alpaView.alpha=0.8;
    [self.view addSubview:_alpaView];


    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, _height, _width, _height-64)];
    _scrollView.backgroundColor=[UIColor whiteColor];

    [self.view addSubview:_scrollView];

    _refesh=[SDRefreshHeaderView refreshView];
    __block myAdressVC*blockSelf=self;
    [_refesh addToScrollView:_scrollView];

    _refesh.beginRefreshingOperation=^{
        [blockSelf getdata];


    };
    _refesh.isEffectedByNavigationController=NO;


    _refeshDown=[SDRefreshFooterView refreshView];
    [_refeshDown addToScrollView:_tableView];

    _refeshDown.beginRefreshingOperation=^{
        [blockSelf getdata];
        
        
    };





}
-(void)getdata
{
    UIImageView*iv=(UIImageView*)[_tableView viewWithTag:222222];
    UILabel*la=(UILabel*)[_tableView viewWithTag:2222222];
    [iv removeFromSuperview];
    [la removeFromSuperview];
    LOADVIEW

    [requestData getData:ASK_ADRESS_URL(USERID) complete:^(NSDictionary *dic) {
        NSLog(@"=======%@",dic);
        LOADREMOVE
     //   LOADING_REMOVE
        [_refeshDown endRefreshing];
        [_refesh endRefreshing];


       _adressArray=[NSMutableArray arrayWithArray:[dic objectForKey:@"data"]];

        [_tableView reloadData];




        if (_adressArray.count==0||_adressArray==nil) {
            UIImageView*tanhao=[[UIImageView alloc]initWithFrame:CGRectMake((_width-50)/2, (_height-260)/2, 50,50)];
            tanhao.image=[UIImage imageNamed:@"tanhao"];
            [_tableView addSubview:tanhao];

            UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (_height-260)/2+60, _width, 20)];
            tishi.text=@"没有收货地址..";
            tishi.textColor=[UIColor grayColor];
            tishi.textAlignment=NSTextAlignmentCenter;
            tishi.font=[UIFont systemFontOfSize:14];
            [_tableView addSubview:tishi];

            tanhao.tag=222222;
            tishi.tag=2222222;
        }


    }];
//
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 15 ;
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
    return _adressArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.whoPush isEqualToString: @"dingdan"]) {
        //NSLog(@"hh%@",[_adressArray objectAtIndex:indexPath.section]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"myaddress" object:nil userInfo:@{@"mya":[_adressArray objectAtIndex:indexPath.section]}];
  
       POP
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    addressCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[addressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];


    }
    NSString*linkName=[[_adressArray objectAtIndex:indexPath.section] objectForKey:@"linkName"];
    NSString*phone=[[_adressArray objectAtIndex:indexPath.section] objectForKey:@"phone"];
    NSString*address=[[_adressArray objectAtIndex:indexPath.section] objectForKey:@"address"];
    NSString*string=[[_adressArray objectAtIndex:indexPath.section] objectForKey:@"isDefault"];
    int isdefault=[string intValue];
     cell.isdefault_B.selected=YES;
    if (isdefault==1) {
        cell.isdefault_IV.image=[UIImage imageNamed:@"default2"];
//        _lastButton=cell.isdefault_B;
//        cell.isdefault_B.selected=YES;

    }else
    {
         cell.isdefault_IV.image=[UIImage imageNamed:@"default1"];
       // cell.isdefault_B.selected=NO;
    }

    cell.linkName_L.text=linkName;
    cell.phone_L.text=phone;
    cell.address_L.text=address;
    [cell.isdefault_B addTarget:self action:@selector(setDefaultClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.alter_B addTarget:self action:@selector(alterClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.delete_B addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];

    cell.isdefault_B.tag=cell.alter_B.tag=cell.delete_B.tag=indexPath.section;
    return cell;


}
-(void)setDefaultClick:(UIButton*)btn
{

    UIImageView*imageV1=(UIImageView*)[btn viewWithTag:1111];
    UIImageView*imageV2=(UIImageView*)[_lastButton viewWithTag:1111];

    if (_lastButton==btn) {
        if (btn.selected) {
            imageV1.image=[UIImage imageNamed:@"default1"];
            btn.selected=NO;

        }else
        {

            imageV1.image=[UIImage imageNamed:@"default2"];
            btn.selected=YES;

        }

    }else
    {
        NSLog(@"jinlai");

        imageV2.image=[UIImage imageNamed:@"default1"];
         imageV1.image=[UIImage imageNamed:@"default2"];
        btn.selected=NO;

         _lastButton=btn;



    }
    NSString*linkName=[[_adressArray objectAtIndex:btn.tag] objectForKey:@"linkName"];
    NSString*phone=[[_adressArray objectAtIndex:btn.tag] objectForKey:@"phone"];
    NSString*address=[[_adressArray objectAtIndex:btn.tag] objectForKey:@"address"];
    int addressId=[[[_adressArray objectAtIndex:btn.tag] objectForKey:@"addressId"] intValue];


    NSLog(@"-------%@",ALTER_ADRESS_URL(USERID, linkName, address, phone, 1, addressId));
    [requestData getData:ALTER_ADRESS_URL(USERID, linkName, address, phone, 1, addressId) complete:^(NSDictionary *dic) {

        if ([[dic objectForKey:@"flag"] intValue]==1) {

            [self getdata];
            MISSINGVIEW
            missing_v.tishi=@"设置成功！";

        }else
        {
            MISSINGVIEW
            missing_v.tishi=@"设置失败！";

        }


    }];

}

-(void)alterClick:(UIButton*)btn
{
    PUSH(alterAddressVC)
    vc.dataDic=(NSDictionary*)[_adressArray objectAtIndex:btn.tag];
    


}
-(void)alterView:(UIButton*)btn
{


    NSString*linkName=[[_adressArray objectAtIndex:btn.tag] objectForKey:@"linkName"];
    NSString*phone=[[_adressArray objectAtIndex:btn.tag] objectForKey:@"phone"];
    NSString*address=[[_adressArray objectAtIndex:btn.tag] objectForKey:@"address"];
    _addressId=[[[_adressArray objectAtIndex:btn.tag] objectForKey:@"addressId"] intValue];
    _isdefault=[[[_adressArray objectAtIndex:btn.tag] objectForKey:@"isDefault"] intValue];


    _adress_tf.placeholder=nil;
    _detailA_tf.placeholder=nil;
    _name_tf.placeholder=nil;
    _phone_tf.placeholder=nil;
    _email_tf.placeholder=nil;

    [_adress_tf becomeFirstResponder];
    _adress_tf.keyboardType=UIKeyboardTypeDefault;
    _phone_tf.keyboardType=UIKeyboardTypeNumberPad;
    _email_tf.keyboardType=UIKeyboardTypeEmailAddress;





    _alpaView.frame=CGRectMake(0, 0, _width, 64);

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _scrollView.frame=CGRectMake(0,64, _width,_height-64);
    [self.view bringSubviewToFront:_scrollView];
    [UIView commitAnimations];


    GRAY_VIEW(gray, 0, 15);

    LEFT_ADRESS_L(label1, @"所在省市区", 15, 50, 14);

    _provice_B=[UIButton buttonWithType:UIButtonTypeCustom];
    _provice_B.frame=CGRectMake(_width*0.43, 15, _width*0.5, 50);
    [_provice_B setTitle:@"选择省 v 市 v 区 v" forState:UIControlStateNormal];
    [_provice_B setTitleColor:RGB(180, 180, 180) forState:UIControlStateNormal];
    _provice_B.titleLabel.font=[UIFont systemFontOfSize:14];
    _provice_B.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [_provice_B addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    _provice_B.tag=1;
    _provice_B.titleLabel.numberOfLines=0;
    [_scrollView addSubview:_provice_B];
    //RIGHT_ADRESS_TF(_adress_tf, @"陕西省西安市雁塔区", 15);
     //[_adress_tf becomeFirstResponder];
    GRAY_SHU_LINE(shu1, 25)
    GRAY_LINE(grayline1, 65);

    LEFT_ADRESS_L(label2, @"详细地址", 15+50, 50, 14);
    RIGHT_ADRESS_TF(_detailA_tf, address, 15+50);
    GRAY_SHU_LINE(shu2, 25+50)
    GRAY_LINE(grayline2, 65+50);

    LEFT_ADRESS_L(label3, @"收货人姓名", 15+50+50, 50, 14);
    RIGHT_ADRESS_TF(_name_tf, linkName, 15+50+50);
    GRAY_SHU_LINE(shu3, 25+50+50)
    GRAY_LINE(grayline3, 65+50+50);

    LEFT_ADRESS_L(label4, @"联系电话", 15+50+50+50, 50, 14);
    RIGHT_ADRESS_TF(_phone_tf, phone, 15+50+50+50);
    GRAY_SHU_LINE(shu4, 25+50+50+50)
    GRAY_LINE(grayline4, 65+50+50+50);

    LEFT_ADRESS_L(label5, @"邮编", 15+50+50+50+50, 50, 14);
    RIGHT_ADRESS_TF(_email_tf, @"请输入邮编", 15+50+50+50+50);
    GRAY_SHU_LINE(shu5, 25+50+50+50+50)
    GRAY_LINE(grayline5, 65+50+50+50+50);
    GRAY_VIEW(grayview2, 65+50+50+50+50, 500)

    UIButton*saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(_width*0.05, 285, _width*0.4, 40)];
    [saveBtn setBackgroundColor:APP_ClOUR];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:saveBtn];


    UIButton*cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(_width*0.55, 285, _width*0.4, 40)];
    [cancelBtn setBackgroundColor:APP_ClOUR];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:cancelBtn];

}
-(void)cancelBtnClick
{
    [UIView animateWithDuration:0.2 animations:^{
        _scrollView.frame=CGRectMake(0, _height, _width, _height-64);
        _alpaView.frame=CGRectMake(0, -(_height-350), _width, _height-350);

    } completion:^(BOOL finished) {

    }];

   }

-(void)saveBtnClick
{
//    NSLog(@"hhhh");
    if (_ssq_str.length>0&&_detailA_tf.text.length>0&&_name_tf.text.length>0) {


        if ([requestData validateMobile:_phone_tf.text]) {


       [requestData getData:ALTER_ADRESS_URL(USERID, _name_tf.text, _ssq_str, _phone_tf.text, _isdefault, _addressId) complete:^(NSDictionary *dic) {

           if ([dic objectForKey:@"flag"]) {
               [self cancelBtnClick];
               [self getdata];

           }else
           {

           }
           MISSINGVIEW
           missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
       }];




        }else
        {
            MISSINGVIEW
            missing_v.tishi=@"手机格式不正确";
          //  ALERT(@"电话号码格式不正确");
        }
    }else
    {
        MISSINGVIEW
        missing_v.tishi=@"信息不能为空";
       // ALERT(@"信息不能为空");
        
    }
//
}

-(void)deleteClick:(UIButton*)btn
{

    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=btn.tag;
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{


    NSString*addressId=[[_adressArray objectAtIndex:alertView.tag] objectForKey:@"addressId"];
    NSString*string=[[_adressArray objectAtIndex:alertView.tag] objectForKey:@"isDefault"];
    int isdefault=[string intValue];
//
    if (buttonIndex==1) {
        [requestData getData:DELETE_ADRESS_URL(USERID, addressId, isdefault) complete:^(NSDictionary *dic) {
           // ALERT([dic objectForKey:@"info"]);

            [_adressArray removeObjectAtIndex:alertView.tag];

            [self getdata];

        }];
        //NSLog(@"hhhh");
    }
}

-(void)addAdress
{
    addAdressVC*vc=[[addAdressVC alloc ]init];
   
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden=YES;
    //NSLog(@"jiangyaochuxian");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect:) name:@"citySelect" object:nil];

    [self getdata];
}

-(void)backClick
{
    if ([self.whoPush isEqualToString:@"dingdan"]) {
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        self.tabBarController.tabBar.hidden=YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    

}
-(void)selectAddress
{
    //NAV_PUSH(citySelectVC);
    PUSH(citySelectVC)

}

-(void)citySelect:(NSNotification*)noti
{
    NSLog(@"%@",noti.userInfo);
    NSString*_city=[noti.userInfo objectForKey:@"city"];
    NSString*_provice=[noti.userInfo objectForKey:@"provice"];
    NSString*_district=[noti.userInfo objectForKey:@"district"];

    if ([_city isEqualToString:_provice]) {
        _ssq_str=[NSString stringWithFormat:@"%@ %@",_provice,_district];
    }else
    {
        _ssq_str=[NSString stringWithFormat:@"%@ %@ %@",_provice,_city,_district];
    }


    if (_ssq_str.length>22) {
        _provice_B.titleLabel.font=[UIFont systemFontOfSize:12];
        _provice_B.titleLabel.numberOfLines=2;
    }
    [_provice_B setTitle:_ssq_str forState:UIControlStateNormal];
    [_provice_B setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
