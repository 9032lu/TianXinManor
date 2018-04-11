//
//  alterAddressVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-4-30.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "alterAddressVC.h"

#import "citySelectVC.h"
@interface alterAddressVC ()

@end

@implementation alterAddressVC
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"编辑地址")
//    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
//    _scrollView.contentSize=CGSizeMake(_width, _height);
//    _scrollView.delegate=self;
//    //[self.view addSubview:_scrollView];
//    GRAY_VIEW(gray, 0, 15);
//
//    LEFT_ADRESS_L(label1, @"所在省市区", 15, 50, 14);
//
//
//
//
//    //
//
//    //RIGHT_ADRESS_TF(_adress_tf, @"选择生", 15);
//    //    _adress_tf.delegate=self;
//    //    [_adress_tf becomeFirstResponder];
//    GRAY_SHU_LINE(shu1, 25)
//    GRAY_LINE(grayline1, 65);
//
//    LEFT_ADRESS_L(label2, @"详细地址", 15+50, 50, 14);
//    RIGHT_ADRESS_TF(_detailA_tf, @"请输入详细地址", 15+50);
//    GRAY_SHU_LINE(shu2, 25+50)
//    GRAY_LINE(grayline2, 65+50);
//
//    LEFT_ADRESS_L(label3, @"收货人姓名", 15+50+50, 50, 14);
//    RIGHT_ADRESS_TF(_name_tf, @"请输入收货人姓名", 15+50+50);
//    GRAY_SHU_LINE(shu3, 25+50+50)
//    GRAY_LINE(grayline3, 65+50+50);
//
//    LEFT_ADRESS_L(label4, @"联系电话", 15+50+50+50, 50, 14);
//    RIGHT_ADRESS_TF(_phone_tf, @"请输入联系电话", 15+50+50+50);
//    GRAY_SHU_LINE(shu4, 25+50+50+50)
//    GRAY_LINE(grayline4, 65+50+50+50);
//
//    LEFT_ADRESS_L(label5, @"邮编", 15+50+50+50+50, 50, 14);
//    RIGHT_ADRESS_TF(_email_tf, @"请输入邮编", 15+50+50+50+50);
//    GRAY_SHU_LINE(shu5, 25+50+50+50+50)
//    GRAY_LINE(grayline5, 65+50+50+50+50);
//    //GRAY_VIEW(grayview2, 65+50+50+50+50, _height-260)
//
//

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];



}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 90)];
    view.backgroundColor=[UIColor whiteColor];

        UIButton*saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(_width*0.02,20, _width*0.96, 50)];
        [saveBtn setBackgroundColor:APP_ClOUR];
        [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=5;
        [view addSubview:saveBtn];
    return view;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];


    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    tableView.separatorInset=UIEdgeInsetsZero;
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.4, 45)];
    label.textColor=[UIColor blackColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [cell.contentView addSubview:label];

    UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.37, 5, 1, 35)];
    shuxian.backgroundColor=RGB(234, 234, 234);
    [cell.contentView addSubview:shuxian];
    if (indexPath.row==3) {
        label.text=@"所在省市区";

        _provice_B.frame=CGRectMake(_width*0.42, 0, _width*0.5, 45);
        [_provice_B setTitle:@"选择省 v 市 v 区 v" forState:UIControlStateNormal];
        [_provice_B setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _provice_B.titleLabel.font=[UIFont systemFontOfSize:14];
        _provice_B.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [_provice_B addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
        _provice_B.tag=1;
        _provice_B.titleLabel.numberOfLines=0;
        [_scrollView addSubview:_provice_B];



    }
    if (indexPath.row==0) {
        label.text=@"详细地址";
        _detailA_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.42, 0, _width*0.56, 45)];
        _detailA_tf.text=[_dataDic objectForKey:@"address"];
        _detailA_tf.textAlignment=NSTextAlignmentLeft;
        _detailA_tf.textColor=[UIColor darkGrayColor];
        _detailA_tf.font=[UIFont systemFontOfSize:14];
        _detailA_tf.delegate=self;
        [cell.contentView addSubview:_detailA_tf];
    }
    if (indexPath.row==1) {
        label.text=@"收货人姓名";
        _name_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.42, 0, _width*0.56, 45)];
        _name_tf.text=[_dataDic objectForKey:@"linkName"];
        _name_tf.textAlignment=NSTextAlignmentLeft;
        _name_tf.textColor=[UIColor darkGrayColor];
        _name_tf.font=[UIFont systemFontOfSize:14];
        _name_tf.delegate=self;
        [cell.contentView addSubview:_name_tf];
    }
    if (indexPath.row==2) {
        label.text=@"联系电话";
        _phone_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.42, 0, _width*0.56, 45)];
        _phone_tf.text=[_dataDic objectForKey:@"phone"];
        _phone_tf.textAlignment=NSTextAlignmentLeft;
        _phone_tf.textColor=[UIColor darkGrayColor];
        _phone_tf.keyboardType=UIKeyboardTypeNumberPad;
        _phone_tf.font=[UIFont systemFontOfSize:14];
        _phone_tf.delegate=self;
        [cell.contentView addSubview:_phone_tf];
    }
//    if (indexPath.row==0) {
//        label.text=@"邮编";
//        _email_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.42, 0, _width*0.56, 45)];
//        _email_tf.text=[_dataDic objectForKey:@"address"];
//        _email_tf.textAlignment=NSTextAlignmentLeft;
//        _email_tf.textColor=RGB(180, 180, 180);
//        _email_tf.font=[UIFont systemFontOfSize:14];
//        _email_tf.delegate=self;
//        [cell.contentView addSubview:_email_tf];
//    }
    return cell;
}
-(void)selectAddress
{
   
   // PUSH(citySelectVC)

}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_adress_tf resignFirstResponder];
    [_detailA_tf resignFirstResponder];
    [_name_tf resignFirstResponder];
    [_phone_tf resignFirstResponder];
    [_email_tf resignFirstResponder];
}
-(void)saveBtnClick
{
    [_adress_tf resignFirstResponder];
    [_detailA_tf resignFirstResponder];
    [_name_tf resignFirstResponder];
    [_phone_tf resignFirstResponder];
    [_email_tf resignFirstResponder];


    if (_name_tf.text.length!=0&&_phone_tf.text.length!=0&&_detailA_tf.text.length!=0) {
        if ([requestData validateMobile:_phone_tf.text]) {
            int isdefault=[[_dataDic objectForKey:@"isDefault"] intValue];
            int addressId=[[_dataDic objectForKey:@"addressId"] intValue];
            [requestData getData:ALTER_ADRESS_URL(USERID, _name_tf.text, _detailA_tf.text, _phone_tf.text,isdefault,addressId ) complete:^(NSDictionary *dic) {

                if ([[dic objectForKey:@"flag"] intValue]==1) {
                    POP

                }else
                {
                    //ALERT([dic objectForKey:@"info"]);
                    MISSINGVIEW
                    missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                    
                }
            }];
        }else
        {
            MISSINGVIEW
            missing_v.tishi=@"手机格式不正确";
        }
    }




}
-(void)backClick
{

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect:) name:@"citySelect" object:nil];
}
-(void)citySelect:(NSNotification*)noti
{
//    NSLog(@"%@",noti.userInfo);
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
