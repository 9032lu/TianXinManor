//
//  addAdressVC.m
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "addAdressVC.h"
#import "define.h"

#import "citySelectVC.h"
@interface addAdressVC ()

@end

@implementation addAdressVC
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];



    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"新增地址")
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.contentSize=CGSizeMake(_width, _height);
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
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


    //RIGHT_ADRESS_TF(_adress_tf, @"选择生", 15);
//    _adress_tf.delegate=self;
//    [_adress_tf becomeFirstResponder];
    GRAY_SHU_LINE(shu1, 25)
    GRAY_LINE(grayline1, 65);

    LEFT_ADRESS_L(label2, @"详细地址", 15+50, 50, 14);
    RIGHT_ADRESS_TF(_detailA_tf, @"请输入详细地址", 15+50);
    _detailA_tf.font=[UIFont systemFontOfSize:14];
    GRAY_SHU_LINE(shu2, 25+50)
    GRAY_LINE(grayline2, 65+50);

    LEFT_ADRESS_L(label3, @"收货人姓名", 15+50+50, 50, 14);
    RIGHT_ADRESS_TF(_name_tf, @"请输入收货人姓名", 15+50+50);
    _name_tf.font=[UIFont systemFontOfSize:14];
    GRAY_SHU_LINE(shu3, 25+50+50)
    GRAY_LINE(grayline3, 65+50+50);

    LEFT_ADRESS_L(label4, @"联系电话", 15+50+50+50, 50, 14);
    RIGHT_ADRESS_TF(_phone_tf, @"请输入联系电话", 15+50+50+50);
    _name_tf.font=[UIFont systemFontOfSize:14];
    _phone_tf.keyboardType=UIKeyboardTypeNumberPad;
    GRAY_SHU_LINE(shu4, 25+50+50+50)
    GRAY_LINE(grayline4, 65+50+50+50);

    LEFT_ADRESS_L(label5, @"邮编（可不填）", 15+50+50+50+50, 50, 14);
    RIGHT_ADRESS_TF(_email_tf, @"请输入邮编", 15+50+50+50+50);
    GRAY_SHU_LINE(shu5, 25+50+50+50+50)
    GRAY_LINE(grayline5, 65+50+50+50+50);
    //GRAY_VIEW(grayview2, 65+50+50+50+50, _height-260)

    UIButton*saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(_width*0.02, 285, _width*0.96, 50)];
    [saveBtn setBackgroundColor:APP_ClOUR];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    saveBtn.layer.cornerRadius=5;
    [_scrollView addSubview:saveBtn];



}

-(void)selectAddress
{
    //NAV_PUSH(citySelectVC);
    PUSH(citySelectVC)

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

    if (_ssq_str.length>0&&_detailA_tf.text.length>0&&_name_tf.text.length>0) {


        if ([requestData validateMobile:_phone_tf.text]) {




            NSString*headerData=_ssq_str;
            headerData = [headerData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            headerData = [headerData stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            headerData = [headerData stringByReplacingOccurrencesOfString:@"\n" withString:@""];

            NSString*adress=[NSString stringWithFormat:@"%@%@",headerData,_detailA_tf.text];
            //NSLog(@"%@",ADD_ADRESS_URL(userid, _name_tf.text, adress, _phone_tf.text));
//
            LOADVIEW
            [requestData getData:ADD_ADRESS_URL(USERID, _name_tf.text, adress, _phone_tf.text) complete:^(NSDictionary *dic) {
//                NSLog(@"%@",[dic objectForKey:@"info"]);
                LOADREMOVE

                if ([[dic objectForKey:@"flag"] intValue]==1) {
                     [self.navigationController popViewControllerAnimated:YES];
                     //ALERT([dic objectForKey:@"info"])
                }else
                {
                    //ALERT([dic objectForKey:@"info"])
                    //ALERT(@"服务器繁忙，请稍后再试..")
                    MISSINGVIEW
                    missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                }
            }];

        }else
        {
            MISSINGVIEW
            missing_v.tishi=@"手机格式不正确";

        }
    }else
    {
        MISSINGVIEW
        missing_v.tishi=@"信息不能为空";
        //ALERT(@"信息不能为空");

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
