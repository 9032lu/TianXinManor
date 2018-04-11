//
//  setPassWordVC.m
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "setPassWordVC.h"
#import "logInVC.h"
@interface setPassWordVC ()

@end

@implementation setPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN

    if ([self.whoPush isEqualToString:@"shezhi"]) {
        TOP_VIEW(@"修改密码")

    }else{
        TOP_VIEW(@"忘记密码")

    }
    // Do any additional setup after loading the view.


    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.contentSize=CGSizeMake(_width, _height);
    _scrollView.scrollEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.bounces=YES;
    [self.view addSubview:_scrollView];


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _height) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.rowHeight=45;
    //_tableView.bounces=YES;
    //_tableView.scrollEnabled=YES;
    [_scrollView addSubview:_tableView];


    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(_width*0.02, 250, _width*0.96, 45);
    button.backgroundColor=APP_ClOUR;
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=5;
    [_scrollView addSubview:button];


}
-(void)saveInfo
{
    [_phone_tf resignFirstResponder];
    [_coder_L resignFirstResponder];
    [_passWord_tf resignFirstResponder];
    [_passWord_Sure_tf resignFirstResponder];

    if (_phone_tf.text.length!=0&&_coder_L.text.length!=0&&_passWord_tf.text.length!=0&&_passWord_Sure_tf.text.length!=0) {
        if ([requestData validateMobile:_phone_tf.text]) {
            if ([_passWord_tf.text isEqualToString:_passWord_Sure_tf.text]) {
                if ([_coder_L.text isEqualToString:_coderString]) {
                    LOADVIEW
                    [requestData getData:ALTER_PASSWORD_URL(_phone_tf.text, _passWord_tf.text) complete:^(NSDictionary *dic) {
                        LOADREMOVE
                        if ([[dic objectForKey:@"flag"] intValue]==1) {
                            [requestData cancelLonIn];



                            if ([self.whoPush isEqualToString:@"denglu"]) {
                                [self dismissViewControllerAnimated:YES completion:^{

                                }];
                            }else
                            {
                                ALLOC(logInVC)
                                [self presentViewController:vc animated:NO completion:^{
                                    [self.navigationController popToRootViewControllerAnimated:NO];
                                }];

                            }

                        }else
                        {
                            
                            MISSINGVIEW
                            missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                        }
                    }];
                }else{
                    MISSINGVIEW
                    missing_v.tishi=@"验证码不匹配";

                }

            }else
            {
                MISSINGVIEW
                missing_v.tishi=@"密码不匹配";
               // ALERT(@"输入密码不匹配")
            }

        }else
        {
            MISSINGVIEW
            missing_v.tishi=@"手机格式不正确";
//            ALERT(@"输入邮箱格式不正确")
        }

    }else
    {
        MISSINGVIEW
        missing_v.tishi=@"信息不完整";
//        ALERT(@"信息不完整")
    }


}
-(void)getCoder
{
    if (_phone_tf.text.length==0) {
        ALERT(@"请输入手机号码")
    }else
    {
        if (![requestData validateMobile:_phone_tf.text]) {
            ALERT(@"手机号码格式不正确")
        }else
        {
            if (_timer==nil) {
                _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCheck) userInfo:nil repeats:YES];
            }

            [requestData getData:REGCODE_URL(_phone_tf.text) complete:^(NSDictionary *dic) {
                _coderString=[dic objectForKey:@"checkCode"];


                if ([[dic objectForKey:@"flag"] intValue]==1) {
//                    _coder_L.text=_coderString;
                    // ALERT([dic objectForKey:@"info"])
                    MISSINGVIEW
                    missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
//                    [_getCoderButton setTitle:@"重新获取" forState:UIControlStateNormal];
//                    [_timer invalidate];
//                    _timer=nil;


                }else
                {
                    MISSINGVIEW
                    missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                    //          ALERT([dic objectForKey:@"info"])
                    [_getCoderButton setTitle:@"重新获取" forState:UIControlStateNormal];
                    _getCoderButton.titleLabel.font=[UIFont systemFontOfSize:15];
                    [_timer invalidate];
                    _timer=nil;
                }

            }];

            

        }


    }

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else
    {
        return 2;
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];

    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.31, 45)];
            nickName_L.text=@"手机号码";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentCenter;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.35, 10, 1, 25)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];

            _phone_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.39, 3, _width*0.8, 42)];
            _phone_tf.placeholder=@"请输入手机号码";
            _phone_tf.delegate=self;
            _phone_tf.keyboardType=UIKeyboardTypeNumberPad;
            [_phone_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:_phone_tf];
        }else
        {
//            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.31, 45)];
//            nickName_L.text=@"旧密码";
//            nickName_L.font=[UIFont systemFontOfSize:14];
//            nickName_L.textAlignment=NSTextAlignmentCenter;
//            [cell addSubview:nickName_L];

            _getCoderButton=[UIButton buttonWithType:UIButtonTypeCustom];
            _getCoderButton.frame=CGRectMake(0, 0, _width*0.35, 50);
            [_getCoderButton setTitle:@"获取验证码" forState:UIControlStateNormal];
            [_getCoderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            _getCoderButton.backgroundColor=[UIColor lightGrayColor];
            _getCoderButton.titleLabel.font=[UIFont systemFontOfSize:15];
            [_getCoderButton addTarget:self action:@selector(getCoder) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:_getCoderButton];

            UIView*kuang=[[UIView alloc]init];
            kuang.frame=CGRectMake(0, 0, _width*0.3, 34);
            kuang.center =_getCoderButton.center;
            kuang.layer.borderColor=[UIColor darkGrayColor].CGColor;
            kuang.layer.borderWidth=1;
            kuang.layer.cornerRadius=5;
            [cell.contentView addSubview:kuang];


            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.35, 10, 1, 25)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];

            _coder_L=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.39, 3, _width*0.8, 42)];
            _coder_L.placeholder=@"请输入验证码";
            _coder_L.delegate=self;
            _coder_L.secureTextEntry=NO;
            _coder_L.keyboardType=UIKeyboardTypeNumberPad;


            [_coder_L setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:_coder_L];

        }

    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.31, 45)];
            nickName_L.text=@"新密码";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentCenter;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.35, 10, 1, 25)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];

            _passWord_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.39, 3, _width*0.8, 42)];
            _passWord_tf.placeholder=@"请输入新密码";
            _passWord_tf.secureTextEntry=YES;
            [_passWord_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:_passWord_tf];
        }else
        {
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.31, 45)];
            nickName_L.text=@"确认密码";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentCenter;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.35, 10, 1, 25)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];

            _passWord_Sure_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.39, 3, _width*0.8, 42)];
            _passWord_Sure_tf.secureTextEntry=YES;
            _passWord_Sure_tf.placeholder=@"请输入确认密码";
            [_passWord_Sure_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:_passWord_Sure_tf];
            
        }
    }

    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"fvbjnk");
    [_phone_tf resignFirstResponder];
    [_coder_L resignFirstResponder];
    [_passWord_tf resignFirstResponder];
    [_passWord_Sure_tf resignFirstResponder];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

-(void)timeCheck
{
    _getCoderButton.userInteractionEnabled=NO;
    _time++;
//    [_getCoderButton setTitle:[NSString stringWithFormat:@"还剩%d秒",60-_time] forState:UIControlStateNormal];
////    _coder_L.placeholder=[NSString stringWithFormat:@"%d秒后重新获取",60-_time];
//
//
//    if (_time>60) {
//
//
//        [_timer invalidate];
//         _coder_L.placeholder=@"请输入验证码";
//
//
//        _timer=nil;
//        _getCoderButton.userInteractionEnabled=YES;
//        
//        _time=0;
//        
//        
//    }


    if (60-_time==-1) {
        [_getCoderButton setTitle:@"重新获取" forState:UIControlStateNormal];
        _getCoderButton.titleLabel.font=[UIFont systemFontOfSize:15];
    }else
    {
        [_getCoderButton setTitle:[NSString stringWithFormat:@"还剩%d秒",60-_time] forState:UIControlStateNormal];
        _getCoderButton.titleLabel.font=[UIFont systemFontOfSize:14];
    }

    if (_time>60) {
        [_timer invalidate];
        _timer=nil;
        _getCoderButton.userInteractionEnabled=YES;

        _time=0;

    }


    
    
}
-(void)backClick
{
    if ([self.whoPush isEqualToString:@"denglu"]) {
        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }else
    {
        POP

    }

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
