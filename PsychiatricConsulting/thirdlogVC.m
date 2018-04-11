//
//  thirdlogVC.m
//  TianXinManor
//
//  Created by apple on 15/11/5.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "thirdlogVC.h"
#import "define.h"
#import "personCenter.h"
#import "logInVC.h"
@interface thirdlogVC ()<UITextFieldDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation thirdlogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"只差一步，即可完成登录设置")


//    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
//    _tableView.delegate=self;
//    _tableView.dataSource=self;
//    _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    _tableView.bounces=NO;

//    [self.view addSubview:_tableView];

    [self initTopView];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+45, _width, _height-64-45) ];
    _scrollView.bounces= YES;
    _scrollView.delegate = self;
    _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

    _scrollView.backgroundColor = RGB(234, 234, 234);

    [self.view addSubview:_scrollView];

    [self initScrollViewData];
    sexDic = [[NSDictionary alloc]initWithObjects:@[@"0",@"1",@"2"] forKeys:@[@"不详",@"男",@"女"]];
    marDic = [[NSDictionary alloc]initWithObjects:@[@"0",@"1",@"2"] forKeys:@[@"保密",@"未婚",@"已婚"]];
    

}

-(void)initTopView{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 64, _width, 45)];
    [self.view addSubview:view];
    for (int i =0; i <2; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame  = CGRectMake(i *_width/2, 0, _width/2, 44);
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitle:@"绑定已有账号" forState:UIControlStateNormal];
            [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
            mybutton = button;
            button.tag = 2;

        }else{
            [button setTitle:@"注册新账号" forState:UIControlStateNormal];
            button.tag = 1;

        }
        [button addTarget:self action:@selector(sellectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }

    UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width/2, 0, 1, 45)];
    shuxian.backgroundColor=RGB(234, 234, 234);
    [view addSubview:shuxian];

    line=[[UIView alloc]initWithFrame:CGRectMake(0, 44, _width, 1)];
    line.backgroundColor=RGB(234, 234, 234);
    [view addSubview:line];

    [view bringSubviewToFront:shuxian];

}

-(void)lablepriceWithHight:(CGFloat)hh andText:(NSString*)text{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, hh, _width, 50)];
    view.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view];

    UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.4, 50)];
    price_L.numberOfLines=1;
    price_L.textAlignment=NSTextAlignmentCenter;
    price_L.textColor=[UIColor darkGrayColor];
    price_L.font=[UIFont systemFontOfSize:15];
    price_L.text=text;
    [view addSubview:price_L];
    UIView *line00 = [[UIView alloc]initWithFrame:CGRectMake(0, 49, _width, 1)];
    line00.backgroundColor = RGB(234, 234, 234);
    [view addSubview:line00];

    UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.37, 5, 1, 40)];
    shuxian.backgroundColor=RGB(234, 234, 234);
    [view addSubview:shuxian];
    

}
-(void)initScrollViewData
{
    for (UIView *obj in _scrollView.subviews) {
        [obj removeFromSuperview];
    }

    if (mybutton.tag==1) {
        [self initRegView];
    }else{
        [self initbindingView];
    }
    
    
}
-(void)initbindingView{
    [self lablepriceWithHight:0 andText:@"手机号码"];
    _phone_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
    _phone_tf.placeholder=@"请输入手机号";
    _phone_tf.keyboardType = UIKeyboardTypeNumberPad;
    [_phone_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _phone_tf.delegate=self;
    _phone_tf.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_phone_tf];


    [self lablepriceWithHight:50 andText:@"密码"];
    _phoneCode=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 50, _width*0.57, 50)];
    _phoneCode.placeholder=@"请输入密码";
    [_phoneCode setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _phoneCode.delegate=self;
    _phoneCode.secureTextEntry=YES;
    _phoneCode.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_phoneCode];


    [self lablepriceWithHight:100 andText:@"确认密码"];
    _password_sure_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 100, _width*0.57, 50)];
    _password_sure_tf.placeholder=@"请再次输入密码";
    _password_sure_tf.secureTextEntry=YES;
    _password_sure_tf.delegate=self;
    [_password_sure_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [_password_sure_tf setFont:[UIFont systemFontOfSize:15]];
    [_scrollView addSubview:_password_sure_tf];



    UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 160, _width, 320)];
    view1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:view1];

    logInBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.frame=CGRectMake(_width*0.05, 55, _width*0.9, 40);
    [logInBtn setTitle:@"绑定账号" forState:UIControlStateNormal];
    [logInBtn setBackgroundColor:APP_ClOUR];

    logInBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logInBtn addTarget:self action:@selector(logBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    logInBtn.layer.cornerRadius=5;
    [view1 addSubview:logInBtn];


    UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 140, _width, 1)];
    hengxian.backgroundColor=RGB(234, 234, 234);
    [view1 addSubview:hengxian];
    _scrollView.contentSize = CGSizeMake(_width, 480);


}
-(void)initRegView{
    [self lablepriceWithHight:0 andText:@"手机号码"];
    _phone_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
    _phone_tf.placeholder=@"请输入手机号";
    _phone_tf.keyboardType = UIKeyboardTypeNumberPad;
    [_phone_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _phone_tf.delegate=self;
    _phone_tf.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_phone_tf];

    [self lablepriceWithHight:50 andText:@""];
    UIView*kuang=[[UIView alloc]initWithFrame:CGRectMake(_width*0.02, 8+50, _width*0.33, 34)];
    kuang.layer.borderColor=[UIColor darkGrayColor].CGColor;
    kuang.layer.borderWidth=1;
    kuang.layer.cornerRadius=5;
    [_scrollView addSubview:kuang];
    _testBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _testBtn.frame=CGRectMake(0, 0+50, _width*0.4, 50);
    [_testBtn setTitle:@"获取验证码"forState:UIControlStateNormal];
    [_testBtn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
    _testBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [_testBtn addTarget:self action:@selector(testBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_testBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, _width*0.05)];
    [_scrollView addSubview:_testBtn];

    _password_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0+50, _width*0.57, 50)];
    _password_tf.placeholder=@"请输入验证码";
    _password_tf.secureTextEntry=NO;
    _password_tf.delegate=self;
    _password_tf.keyboardType = UIKeyboardTypeNumberPad;

    [_password_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _password_tf.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_password_tf];


    [self lablepriceWithHight:120 andText:@"密码"];
    _phoneCode=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 120, _width*0.57, 50)];
    _phoneCode.placeholder=@"请输入密码";
    [_phoneCode setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    _phoneCode.delegate=self;
    _phoneCode.secureTextEntry=YES;
    _phoneCode.font=[UIFont systemFontOfSize:15];
    [_scrollView addSubview:_phoneCode];


    [self lablepriceWithHight:170 andText:@"确认密码"];
    _password_sure_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 170, _width*0.57, 50)];
    _password_sure_tf.placeholder=@"请再次输入密码";
    _password_sure_tf.secureTextEntry=YES;
    _password_sure_tf.delegate=self;
    [_password_sure_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
    [_password_sure_tf setFont:[UIFont systemFontOfSize:15]];
    [_scrollView addSubview:_password_sure_tf];


//    UIButton *view = [[UIButton alloc]initWithFrame:CGRectMake(0, 220, _width, 70)];
//    view.backgroundColor = [UIColor whiteColor];
//    [_scrollView addSubview:view];
//    [view addTarget:self action:@selector(faceclick) forControlEvents:UIControlEventTouchUpInside];
//    UIView *line0 = [[UIView alloc]initWithFrame:CGRectMake(0, 69, _width, 1)];
//    line0.backgroundColor = RGB(234, 234, 234);
//    [view addSubview:line0];
//    _userFace= [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10+220, 50, 50)];
//    _userFace.layer.cornerRadius=25;
//    _userFace.layer.masksToBounds=YES;
//    _userFace.image =[UIImage imageNamed:@"userFace"];
//    [_scrollView addSubview:_userFace];
//    UILabel *Rlab = [[UILabel alloc]init];
//    Rlab.frame=CGRectMake(_width*0.7, 20+220, _width*0.94, 20);
//    Rlab.text = @"上传头像";
//    Rlab.textColor =[UIColor darkGrayColor];
//    Rlab.font =[UIFont systemFontOfSize:13];
//    [_scrollView addSubview:Rlab];
//
//    UIImageView *Rimg=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 21+220, 18, 18)];
//    Rimg.image =[UIImage imageNamed:@"cp2"];
//    Rimg.transform =CGAffineTransformMakeRotation(M_PI*3/2);
//    [_scrollView addSubview:Rimg];
//
    [self lablepriceWithHight:220 andText:@"昵称"];

    _niceName = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 220, _width*0.57, 50)];
    _niceName.placeholder= @"请输入昵称";
    _niceName.delegate=self;
    _niceName.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_niceName];


    [self lablepriceWithHight:220+50+20 andText:@"姓名"];
    _realName = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 220+50+20, _width*0.57, 50)];
    _realName.placeholder= @"请输入真实姓名";
    _realName.delegate=self;
    _realName.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_realName];

    [self lablepriceWithHight:220+50+20+50 andText:@"性别"];
    UIImageView *Rimg1=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 16+220+50+20+50, 18, 18)];
    Rimg1.image =[UIImage imageNamed:@"cp2"];
    Rimg1.transform =CGAffineTransformMakeRotation(M_PI*3/2);
    [_scrollView addSubview:Rimg1];
    _sexlab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.43, 220+50+20+50, 50, 50)];
    _sexlab.font = [UIFont systemFontOfSize:15];
    _sexlab.textColor =[UIColor darkGrayColor];
    _sexlab.text = @"不详";
    [_scrollView addSubview:_sexlab];
    UIButton *sexBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 340, _width, 50)];
    [sexBtn addTarget:self action:@selector(sexbtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:sexBtn];


    [self lablepriceWithHight:340+50 andText:@"婚姻状态"];
    UIImageView *Rimg0=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 16+390, 18, 18)];
    Rimg0.image =[UIImage imageNamed:@"cp2"];
    Rimg0.transform =CGAffineTransformMakeRotation(M_PI*3/2);
    [_scrollView addSubview:Rimg0];
    _marrayStatu = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.43, 390, 50, 50)];
    _marrayStatu.textColor =[UIColor darkGrayColor];
    _marrayStatu.text = @"保密";
    _marrayStatu.font =[UIFont systemFontOfSize:15];
    [_scrollView addSubview: _marrayStatu];

    UIButton *marryBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 390, _width, 50)];
    [marryBtn addTarget:self action:@selector(marrybtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:marryBtn];



    [self lablepriceWithHight:440 andText:@"身份证号码"];
    _identifierCode = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 440, _width*0.57, 50)];
    _identifierCode.placeholder= @"请输入身份证号码";
    _identifierCode.delegate=self;
    _identifierCode.keyboardType= UIKeyboardTypeNumbersAndPunctuation;
    _identifierCode.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_identifierCode];

//    [self lablepriceWithHight:460+70+50 andText:@"电子邮件"];
//    _email = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 460+70+50, _width*0.57, 50)];
//    _email.placeholder= @"请输入电子邮件";
//    _email.delegate=self;
//    _email.keyboardType = UIKeyboardTypeEmailAddress;
//    _email.font = [UIFont systemFontOfSize:15];
//    [_scrollView addSubview:_email];


    UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 490+20, _width, 320)];
    view1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:view1];






    logInBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.frame=CGRectMake(_width*0.05, 55, _width*0.9, 40);
    [logInBtn setTitle:@"注册新账号" forState:UIControlStateNormal];
    //            _logInBtn.backgroundColor=[UIColor grayColor];
    [logInBtn setBackgroundColor:APP_ClOUR];

    logInBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [logInBtn addTarget:self action:@selector(logBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    logInBtn.layer.cornerRadius=5;
    [view1 addSubview:logInBtn];


    UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 140, _width, 1)];
    hengxian.backgroundColor=RGB(234, 234, 234);
    [view1 addSubview:hengxian];
    
    _scrollView.contentSize = CGSizeMake(_width, 830);


}


-(void)sellectBtn:(UIButton *)button{
    logInBtn.tag = button.tag;
    if (button.tag==2) {
        [logInBtn setTitle:@"绑定账号" forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.1 animations:^{
//            line.frame =CGRectMake(0, 44, _width/2, 2);
//        }];

    }else{
        [logInBtn setTitle:@"立即注册" forState:UIControlStateNormal];
//        [UIView animateWithDuration:0.1 animations:^{
//            line.frame =CGRectMake(_width/2, 44, _width/2, 2);
//        }];

    }


    if (mybutton!=button) {
        [button setTitleColor:APP_ClOUR forState:UIControlStateNormal];
        [mybutton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];

        mybutton = button;
    }

    [self initScrollViewData];
}


-(void)logBtnBtnClick:(UIButton*)button{

    [_phone_tf resignFirstResponder];
    [_password_tf resignFirstResponder];
    [_password_sure_tf resignFirstResponder];
    [_niceName resignFirstResponder];
    [_realName resignFirstResponder];
    [_identifierCode resignFirstResponder];
    [_email resignFirstResponder];


    if (![requestData validateMobile:_phone_tf.text]) {
        MISSINGVIEW
        missing_v.tishi=@"手机格式不正确！";

    }else{
        if (_phone_tf.text.length==0) {
            // ALERT(@"请输入邮箱")
            MISSINGVIEW
            missing_v.tishi=@"请输入手机号";
        }else
        {
            if (_phoneCode.text.length==0) {
                //ALERT(@"请输入密码")
                MISSINGVIEW
                missing_v.tishi=@"请输入密码";
            }else{
                if (![_phoneCode.text isEqualToString:_password_sure_tf.text]) {
                    MISSINGVIEW
                    missing_v.tishi=@"密码不一致";
                }else{

                    if (mybutton.tag!=1) {
                        LOADVIEW
                          NSString* birthday= [requestData GetBrithdayFromIdCard:_identifierCode.text];
                        NSString *urlstring=[NSString stringWithFormat:@"%@/users/thridLogin.action?%@=%@&userType=%@&userId=%@&password=%@&birthDay=%@",BASE_URL,self.Auth_UID,self.usid,@"2",_phone_tf.text,_phoneCode.text,birthday];

                        [requestData getData:urlstring complete:^(NSDictionary *dic) {
                            NSLog(@"------%@",urlstring);
                            LOADREMOVE
                            //                        NSLog(@"第三方登录=====%@",dic);

                            if ([dic[@"flag"]integerValue]==0) {
                                MISSINGVIEW
                                missing_v.tishi = dic[@"info"];
                            }else{

                                [[NSUserDefaults standardUserDefaults] setObject:[dic[@"data"] objectForKey:@"userId"] forKey:@"userId"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                                NSLog(@"第三方登录成功");

                                self.presentingViewController.view.alpha = 0;
                                [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];

                                //                    [self dismissViewControllerAnimated:YES completion:^{
                                //
                                //                    }];
                                //                            POP
                                
                            }
                            
                        }];

                    }else{


                        if (![_password_tf.text isEqualToString:checkCode]) {
                            MISSINGVIEW
                            missing_v.tishi=@"验证码不正确";
                        }else{
                            if (_niceName.text.length ==0) {
                                MISSINGVIEW
                                missing_v.tishi=@"请输入昵称";
                            }else{
                                if (_realName.text.length ==0) {
                                    MISSINGVIEW
                                    missing_v.tishi=@"请输入真实姓名";
                                }else{
                                    LOADVIEW
                                    NSString *urlstring=[NSString stringWithFormat:@"%@/users/thridLogin.action?%@=%@&userType=%@&userId=%@&password=%@&nickName=%@&sex=%@&maritalStatus=%@&identityCard=%@",BASE_URL,self.Auth_UID,self.usid,@"1",_phone_tf.text,_phoneCode.text,_niceName.text,[sexDic objectForKey:_sexlab.text],[marDic objectForKey:_marrayStatu.text],_identifierCode.text];

                                    [requestData getData:urlstring complete:^(NSDictionary *dic) {
                                        NSLog(@"------%@",urlstring);
                                        LOADREMOVE
                                        //                        NSLog(@"第三方登录=====%@",dic);

                                        if ([dic[@"flag"]integerValue]==0) {
                                            MISSINGVIEW
                                            missing_v.tishi = dic[@"info"];
                                        }else{

                                            [[NSUserDefaults standardUserDefaults] setObject:[dic[@"data"] objectForKey:@"userId"] forKey:@"userId"];
                                            [[NSUserDefaults standardUserDefaults] synchronize];
                                            NSLog(@"第三方登录成功");

                                            self.presentingViewController.view.alpha = 0;
                                            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];

                                            //                    [self dismissViewControllerAnimated:YES completion:^{
                                            //
                                            //                    }];
                                            //                            POP
                                            
                                        }
                                        
                                    }];

                                }
                            }
                            
                        }


                        

                        
                    }
                                   }
                
            }
        }
        

    }

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
-(void)testBtnClick{
    [_phone_tf resignFirstResponder];
    [_password_tf resignFirstResponder];
    [_password_sure_tf resignFirstResponder];
    [_realName resignFirstResponder];
    [_niceName resignFirstResponder];
    [_identifierCode resignFirstResponder];
    [_email resignFirstResponder];

    if (_phone_tf.text.length==0) {
        MISSINGVIEW
        missing_v.tishi=@"请输入手机号";
        //        ALERT(@"请输入手机号")
        return;
    }
    if ([requestData validateMobile:_phone_tf.text]) {

    }else
    {
        MISSINGVIEW
        missing_v.tishi=@"手机格式不正确";
        //        ALERT(@"手机格式不正确")
        return;
    }

    if (_timer==nil) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCheck) userInfo:nil repeats:YES];
    }
    //    NSLog(@"%@",REGCODE_URL(@"1"));
    [requestData getData:REGCODE_URL(_phone_tf.text) complete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"flag"] intValue]==1) {
            checkCode=[dic objectForKey:@"checkCode"];
            // ALERT([dic objectForKey:@"info"])
            MISSINGVIEW
            missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];

        }else
        {
            MISSINGVIEW
            missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
            //          ALERT([dic objectForKey:@"info"])
            [_testBtn setTitle:@"重新获取" forState:UIControlStateNormal];
            _testBtn.titleLabel.font=[UIFont systemFontOfSize:15];
            [_timer invalidate];
            _timer=nil;
        }
    }];


    //
    
    
    
}
-(void)timeCheck
{
    _testBtn.userInteractionEnabled=NO;
    _time++;
    //[_testBtn setTitle:[NSString stringWithFormat:@"%d妙后重新获取",60-_time] forState:UIControlStateNormal];
    //_test_tf.text=[NSString stringWithFormat:@"%d妙后重新获取",60-_time];
    if (60-_time==-1) {
        [_testBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        _testBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    }else
    {
        [_testBtn setTitle:[NSString stringWithFormat:@"还剩%d秒",60-_time] forState:UIControlStateNormal];
        _testBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    }

    if (_time>60) {
        [_timer invalidate];
        _timer=nil;
        _testBtn.userInteractionEnabled=YES;

        _time=0;

    }
    
}
-(void)sexbtn{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"性别" otherButtonTitles:@"不详",@"男",@"女", nil];
    sheet.delegate =self;
    sheet.tag =1;
    [sheet showInView:self.view];


}
-(void)marrybtn{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"婚姻状态" otherButtonTitles:@"保密",@"未婚",@"已婚", nil];
    sheet.delegate =self;
    sheet.tag =2;
    [sheet showInView:self.view];
    
}
-(void)faceclick{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"拍照", nil];
    sheet.delegate =self;
    sheet.tag =0;
    [sheet showInView:self.view];

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==0) {


        if (buttonIndex==0) {
            UIImagePickerController*pc=[[UIImagePickerController alloc]init];
            pc.delegate=self;
            pc.allowsEditing=YES;
            pc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:pc animated:YES completion:^{

            }];

        }
        if (buttonIndex==1) {
            UIImagePickerController*pc=[[UIImagePickerController alloc]init];
            pc.delegate=self;
            pc.allowsEditing=YES;
            pc.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:pc animated:YES completion:^{

            }];

        }

    }else if (actionSheet.tag==1){

        if (buttonIndex==1) {
            _sexlab.text=@"不详";
        }
        if (buttonIndex==2) {
            _sexlab.text=@"男";
        }
        if (buttonIndex==3) {
            _sexlab.text=@"女";
        }

    }else{
        if (buttonIndex==1) {
            _marrayStatu.text =@"保密";
        }
        if (buttonIndex==2) {
            _marrayStatu.text =@"未婚";

        }
        if (buttonIndex==3) {
            _marrayStatu.text =@"已婚";
        }


    }

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{

        NSIndexPath*path=[NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell*cell=[_tableView cellForRowAtIndexPath:path];

        UIImageView*imagev=(UIImageView*)[cell.contentView viewWithTag:80];
        imagev.image=[info objectForKey:UIImagePickerControllerEditedImage];
        UIImage*image=[info objectForKey:UIImagePickerControllerEditedImage];
        NSData*data=UIImageJPEGRepresentation(image, 1.0);
        _imageDataStr=[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        _userFace.image=image;
        //NSLog(@"%@",_imageDataStr);
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
