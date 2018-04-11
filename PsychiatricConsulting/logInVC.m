//
//  logInVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "logInVC.h"
#import "registerVC.h"
#import "danli.h"
#import "setPassWordVC.h"
#import "homePage.h"
#import "ShequViewController.h"
#import "UMSocial.h"
@interface logInVC ()<UMSocialUIDelegate>

@end

@implementation logInVC


- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"登录")
     danli*myapp=[danli shareClient];
    myapp.isremember=YES;

    platArray = @[UMShareToQzone,UMShareToWechatSession,UMShareToSina];
    platAuthArray = @[@"qq_Auth_UID",@"wx_Auth_UID",@"wb_Auth_UID"];

    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(_width*0.8, 22, _width*0.2, 40)];
//    [button setTitle:@"注册" forState:UIControlStateNormal];

    NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:@"注册"];
    [atts addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 2)];
    [atts addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 2)];
    [button setAttributedTitle:atts forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:16];

    [button addTarget:self action:@selector(registerbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.navigationController.navigationBar.hidden=YES;


    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.bounces=YES;

    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else
    {
        return 1;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 20;
    }else
    {
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 320+40;
    }else
    {
        return 1;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 320+40)];
        view.backgroundColor=[UIColor whiteColor];


        UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.95, 50)];
        price_L.numberOfLines=1;

        NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:@"忘记密码？"];

        [atts addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 5)];
        price_L.attributedText=atts;
        price_L.textAlignment=NSTextAlignmentRight;
        price_L.textColor=APP_ClOUR;
        price_L.font=[UIFont systemFontOfSize:15];
        [view addSubview:price_L];

        UILabel*price_L1=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.15, 0, _width*0.2, 50)];
        price_L1.numberOfLines=1;
        NSMutableAttributedString*atts1=[[NSMutableAttributedString alloc]initWithString:@"记住密码"];

        [atts1 addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, 4)];
        price_L1.attributedText=atts1;
        price_L1.textAlignment=NSTextAlignmentLeft;
        price_L1.textColor=APP_ClOUR;
        price_L1.font=[UIFont systemFontOfSize:15];
        [view addSubview:price_L1];


        UIButton*jizhumima=[UIButton buttonWithType:UIButtonTypeCustom];
        jizhumima.frame=CGRectMake(_width*0.05, 0, _width*0.3, 50);
        [jizhumima addTarget:self action:@selector(jizhumimaClick:) forControlEvents:UIControlEventTouchUpInside];
        [jizhumima setImage:[UIImage imageNamed:@"jizhu1"] forState:UIControlStateNormal];
        [jizhumima setImage:[UIImage imageNamed:@"jizhu2"] forState:UIControlStateSelected];
        [jizhumima setImageEdgeInsets:UIEdgeInsetsMake(20, _width*0.1-15, 20, _width*0.2+5)];
        [view addSubview:jizhumima];



        UIButton*regBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        regBtn.frame=CGRectMake(_width*0.8, 0, _width*0.2, 50);
        [regBtn addTarget:self action:@selector(forgetPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:regBtn];



        UIButton*logInBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        logInBtn.frame=CGRectMake(_width*0.05, 55, _width*0.9, 40);
        logInBtn.tag=4;
        [logInBtn setTitle:@"登录" forState:UIControlStateNormal];
        logInBtn.backgroundColor=APP_ClOUR;
        logInBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [logInBtn addTarget:self action:@selector(logBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        logInBtn.layer.cornerRadius=5;
        [view addSubview:logInBtn];


        UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 140+40, _width, 1)];
        hengxian.backgroundColor=RGB(234, 234, 234);
        [view addSubview:hengxian];

        UILabel *labb = [[UILabel alloc]initWithFrame:CGRectMake((_width-110)/2, 140-15+40, 110, 30)];
        labb.text = @"第三方登录";
        labb.backgroundColor = [UIColor whiteColor];
        labb.textColor = [UIColor darkGrayColor];
        labb.font =[UIFont systemFontOfSize:15];
        labb.textAlignment = NSTextAlignmentCenter;
        [view addSubview:labb];

        for (int i =0; i < 3; i ++) {
            UIButton *buttonlog = [[UIButton alloc]initWithFrame:CGRectMake(_width/3*i, 160+40, _width/3, 44)];
            buttonlog.tag = 1000+i;

            [buttonlog addTarget:self action:@selector(logOtherway:) forControlEvents:UIControlEventTouchUpInside];

            [view addSubview:buttonlog];;

            UIImageView *imagev = [[UIImageView alloc]init];
            imagev.bounds = CGRectMake(0, 0, 44, 44);
            imagev.center = buttonlog.center;
            if (i==0) {
                imagev.image =[UIImage imageNamed:@"icon-qq"];
            }
            if (i==2) {
                imagev.image =[UIImage imageNamed:@"icon-weibo"];
            }

            if (i==1) {
                imagev.image =[UIImage imageNamed:@"icon-weixin"];
            }

            [view addSubview:imagev];

            [view bringSubviewToFront:buttonlog];

        }
        return view;
    }else
    {
        return nil;
    }
}
-(void)thridlogWithId:(NSString*)idstring{

    NSString *urlstring=[NSString stringWithFormat:@"%@/users/thridLogin.action?%@=%@",BASE_URL,markPlat,idstring];

//    NSLog(@"////////////==%@",urlstring);
    LOADVIEW
    [requestData getData:urlstring complete:^(NSDictionary *dic) {
        LOADREMOVE
        if ([dic[@"flag"]integerValue]==0) {

            ALLOC(thirdlogVC)
            vc.usid = idstring;
            vc.Auth_UID = markPlat;
            [self presentViewController:vc animated:YES completion:^{

            }];
        }else{


            [[NSUserDefaults standardUserDefaults] setObject:[dic[@"data"] objectForKey:@"userId"] forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
//            POP
            if (self.presentingViewController) {
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];

            }

        }


    }];


}



-(void)logOtherway:(UIButton*)sender
{
//qq平台


//
//    if (sender.tag == 1000) {
//



//              //判断是否授权
//        BOOL isOauth = [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToQzone];
//        if (isOauth == YES) {
//            //授权成功，获取微博平台账户信息
//            NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
//            //创建一个微博账户对象
//            UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToQzone];
//            NSLog(@"sina name is %@, icon URL is %@",sinaAccount.userName,sinaAccount.iconURL);
//            //获取用户微博账号详细信息
//            [[UMSocialDataService defaultDataService]requestSnsInformation:UMShareToQzone completion:^(UMSocialResponseEntity *response) {
//                NSLog(@"response is %@",response.data);
//                
//UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQzone];
//
//                NSString *urlstring=[NSString stringWithFormat:@"%@/users/thridLogin.action?qq_Auth_UID=%@",BASE_URL,snsAccount.usid];
//
//                [self thirdLoginwithURL:urlstring];
//
//            }];
//        }else{
            //未授权，进入授权页面

    //1 qq 2 微信 3 新浪


    BOOL isOauth = [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToWechatSession];
            if (isOauth == YES) {

                NSLog(@"---------");
            }else{
                NSLog(@"+++++++++");

            }


    platArray = @[UMShareToQzone,UMShareToWechatSession,UMShareToSina];
    platAuthArray = @[@"qq_Auth_UID",@"wx_Auth_UID",@"wb_Auth_UID"];

        [UMSocialSnsPlatformManager getSocialPlatformWithName:platArray[sender.tag-1000]].loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){


            if (response.responseCode == UMSResponseCodeSuccess) {
                //获取微博用户名、uid、token等
                UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:platArray[sender.tag-1000]];
                NSLog(@"usid===%@",snsAccount.usid);
                markPlat = platAuthArray[sender.tag-1000];
                [self thridlogWithId:snsAccount.usid];

            }});




}


-(void)registerbtnClick
{
    ALLOC(registerVC)
    [self presentViewController:vc animated:YES completion:^{

    }];
}
-(void)forgetPasswordBtnClick
{
    ALLOC(setPassWordVC)
    vc.whoPush=@"denglu";

    [self presentViewController:vc animated:YES completion:^{

    }];

}
-(void)jizhumimaClick:(UIButton*)button
{
    if (button.selected) {
        button.selected=NO;


    }else
    {
        button.selected=YES;
        NSLog(@"记住密码");
        danli*myapp=[danli shareClient];
        myapp.isremember=NO;

    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 50;
    }else
    {
        return 50;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    if (indexPath.section==0) {
        if (indexPath.row==0||indexPath.row==1) {
            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.4, 50)];
            price_L.numberOfLines=1;
            price_L.textAlignment=NSTextAlignmentCenter;
            price_L.textColor=[UIColor darkGrayColor];
            price_L.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:price_L];


//            UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 20, 20)];


            if (indexPath.row==0) {
                price_L.text=@"手机号码";
//                imageView.image=[UIImage imageNamed:@"1"];
                _phone_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
                _phone_tf.placeholder=@"请输入手机号";
                [_phone_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
                _phone_tf.delegate=self;
                _phone_tf.keyboardType=UIKeyboardTypeNumberPad;
                _phone_tf.font=[UIFont systemFontOfSize:15];
                [cell.contentView addSubview:_phone_tf];
            }else
            {
//                imageView.image=[UIImage imageNamed:@"2"];
                price_L.text=@"密码";
                _password_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
                _password_tf.placeholder=@"请输入密码";
                _password_tf.secureTextEntry=YES;
                _password_tf.delegate=self;
                [_password_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
                _password_tf.font=[UIFont systemFontOfSize:15];
                [cell.contentView addSubview:_password_tf];
            }
            UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.37, 5, 1, 40)];
            shuxian.backgroundColor=RGB(234, 234, 234);
            [cell.contentView addSubview:shuxian];
        }

    }
    
    
    return cell;
}

-(void)logBtnBtnClick
{
   // NSLog(@"登录");
    [_password_tf resignFirstResponder];
    [_phone_tf resignFirstResponder];
    if (_phone_tf.text.length==0) {
       // ALERT(@"请输入邮箱")
        MISSINGVIEW
        missing_v.tishi=@"信息不完整";
    }else
    {
        if (_password_tf.text.length==0) {
            //ALERT(@"请输入密码")
            MISSINGVIEW
            missing_v.tishi=@"信息不完整";
        }else
        {
            LOADVIEW
            [requestData getData:LOGIN_URL(_phone_tf.text, _password_tf.text) complete:^(NSDictionary *dic) {
                LOADREMOVE
                if ([[dic objectForKey:@"flag"] intValue]==1) {


                    [[NSUserDefaults standardUserDefaults] setObject:_phone_tf.text forKey:@"userId"];
                    [[NSUserDefaults standardUserDefaults] synchronize];

//                    POP
                    [self dismissViewControllerAnimated:YES completion:^{

                    }];



                }else
                {
//                    ALERT([dic objectForKey:@"info"])

                    MISSINGVIEW
                    missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
                }
            }];
        }

    }

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_password_tf resignFirstResponder];
    [_phone_tf resignFirstResponder];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [_password_tf resignFirstResponder];
    [_phone_tf resignFirstResponder];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)backClick
{
//    POP

        [self dismissViewControllerAnimated:YES completion:^{

        }];



}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

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
