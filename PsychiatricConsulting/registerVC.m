//
//  registerVC.m
//  ShengMengShangmao
//
//  Created by apple on 15-3-27.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "registerVC.h"
#import "logInVC.h"
#import "webViewVC.h"
@interface registerVC ()

@end

@implementation registerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"注册")

    self.navigationController.navigationBar.hidden=YES;
//    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
//    _tableView.delegate=self;
//    _tableView.dataSource=self;
//    _tableView.bounces=YES;
    //    [self.view addSubview:_tableView];

    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) ];
    _scrollView.bounces= YES;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = RGB(234, 234, 234);
    _scrollView.contentSize = CGSizeMake(_width, 1000);

    [self.view addSubview:_scrollView];

    [self initScrollViewData];
    sexDic = [[NSDictionary alloc]initWithObjects:@[@"0",@"1",@"2"] forKeys:@[@"不详",@"男",@"女"]];
    marDic = [[NSDictionary alloc]initWithObjects:@[@"0",@"1",@"2"] forKeys:@[@"保密",@"未婚",@"已婚"]];


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
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49, _width, 1)];
    line.backgroundColor = RGB(234, 234, 234);
    [view addSubview:line];

    UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.37, 5, 1, 40)];
    shuxian.backgroundColor=RGB(234, 234, 234);
    [view addSubview:shuxian];



}
-(void)initScrollViewData{
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


    UIButton *view = [[UIButton alloc]initWithFrame:CGRectMake(0, 220, _width, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view];
    [view addTarget:self action:@selector(faceclick) forControlEvents:UIControlEventTouchUpInside];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 69, _width, 1)];
    line.backgroundColor = RGB(234, 234, 234);
    [view addSubview:line];
    _userFace= [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10+220, 50, 50)];
    _userFace.layer.cornerRadius=25;
    _userFace.layer.masksToBounds=YES;
    _userFace.image =[UIImage imageNamed:@"userFace"];
    [_scrollView addSubview:_userFace];
    UILabel *Rlab = [[UILabel alloc]init];
    Rlab.frame=CGRectMake(_width*0.7, 20+220, _width*0.94, 20);
    Rlab.text = @"上传头像";
    Rlab.textColor =[UIColor darkGrayColor];
    Rlab.font =[UIFont systemFontOfSize:13];
    [_scrollView addSubview:Rlab];

    UIImageView *Rimg=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 21+220, 18, 18)];
    Rimg.image =[UIImage imageNamed:@"cp2"];
    Rimg.transform =CGAffineTransformMakeRotation(M_PI*3/2);
    [_scrollView addSubview:Rimg];

    [self lablepriceWithHight:70+220 andText:@"昵称"];

    _niceName = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 70+220, _width*0.57, 50)];
    _niceName.placeholder= @"请输入昵称";
    _niceName.delegate=self;
    _niceName.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_niceName];


    [self lablepriceWithHight:70+220+50+20 andText:@"姓名"];
    _realName = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 70+220+50+20, _width*0.57, 50)];
    _realName.placeholder= @"请输入真实姓名";
    _realName.delegate=self;
    _realName.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_realName];

    [self lablepriceWithHight:70+220+50+20+50 andText:@"性别"];
    UIImageView *Rimg1=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 16+70+220+50+20+50, 18, 18)];
    Rimg1.image =[UIImage imageNamed:@"cp2"];
    Rimg1.transform =CGAffineTransformMakeRotation(M_PI*3/2);
    [_scrollView addSubview:Rimg1];
    _sexlab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.43, 70+220+50+20+50, 50, 50)];
    _sexlab.font = [UIFont systemFontOfSize:15];
    _sexlab.textColor =[UIColor darkGrayColor];
    _sexlab.text = @"不详";
    [_scrollView addSubview:_sexlab];
    UIButton *sexBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 460-50, _width, 50)];
    [sexBtn addTarget:self action:@selector(sexbtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:sexBtn];


    [self lablepriceWithHight:70+220+50+20+50+50 andText:@"婚姻状态"];
    UIImageView *Rimg0=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 16+460, 18, 18)];
    Rimg0.image =[UIImage imageNamed:@"cp2"];
    Rimg0.transform =CGAffineTransformMakeRotation(M_PI*3/2);
    [_scrollView addSubview:Rimg0];
    _marrayStatu = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.43, 460, 50, 50)];
    _marrayStatu.textColor =[UIColor darkGrayColor];
    _marrayStatu.text = @"保密";
    _marrayStatu.font =[UIFont systemFontOfSize:15];
    [_scrollView addSubview: _marrayStatu];

    UIButton *marryBtn= [[UIButton alloc]initWithFrame:CGRectMake(0, 460, _width, 50)];
    [marryBtn addTarget:self action:@selector(marrybtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:marryBtn];



    [self lablepriceWithHight:460+70 andText:@"身份证号码"];
    _identifierCode = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 460+70, _width*0.57, 50)];
    _identifierCode.placeholder= @"请输入身份证号码";
    _identifierCode.delegate=self;
    _identifierCode.keyboardType= UIKeyboardTypeNumbersAndPunctuation;
    _identifierCode.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_identifierCode];

    [self lablepriceWithHight:460+70+50 andText:@"电子邮件"];
    _email = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 460+70+50, _width*0.57, 50)];
    _email.placeholder= @"请输入电子邮件";
    _email.delegate=self;
    _email.keyboardType = UIKeyboardTypeEmailAddress;
    _email.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_email];


    UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 560+70+50, _width, 320)];
    view1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:view1];

    _regBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _regBtn.frame=CGRectMake(0, 0, _width*0.1, 50);
    _regBtn.selected = YES;
    //        [_logInBtn setBackgroundColor:APP_ClOUR];
    [_regBtn addTarget:self action:@selector(duihao:) forControlEvents:UIControlEventTouchUpInside];
    [_regBtn setImage:[UIImage imageNamed:@"jizhu2"] forState:UIControlStateNormal];
    [_regBtn setImage:[UIImage imageNamed:@"jizhu1"] forState:UIControlStateSelected];
    [_regBtn setImageEdgeInsets:UIEdgeInsetsMake(20,(_width*0.1-10), 20, (_width*0.1-10))];
    [view1 addSubview:_regBtn];

    UIButton*agreeMnetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:@"我已看过并同意《天心庄园用户协议》"];
    [atts addAttribute:NSForegroundColorAttributeName value:APP_ClOUR range:NSMakeRange(7, 8)];
    [agreeMnetBtn setAttributedTitle:atts forState:UIControlStateNormal];
    agreeMnetBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    agreeMnetBtn.frame=CGRectMake(_width*0.1, 0, _width*0.8, 50);
    agreeMnetBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [agreeMnetBtn addTarget:self action:@selector(useragreeMnetBtn) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:agreeMnetBtn];



    _logInBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _logInBtn.frame=CGRectMake(_width*0.05, 55, _width*0.9, 40);
    _logInBtn.tag=4;
    [_logInBtn setTitle:@"注册" forState:UIControlStateNormal];
    //        _logInBtn.backgroundColor=[UIColor grayColor];
    [_logInBtn setBackgroundColor:APP_ClOUR];

    _logInBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [_logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_logInBtn addTarget:self action:@selector(logBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _logInBtn.layer.cornerRadius=5;
    [view1 addSubview:_logInBtn];


    UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 140, _width, 1)];
    hengxian.backgroundColor=RGB(234, 234, 234);
    [view1 addSubview:hengxian];





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
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (section==3) {
//        return 3;
//    }else
//    {
//        return 2;
//    }
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 5;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    if (indexPath.section==2&&indexPath.row==0) {
//
//            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"拍照", nil];
//        sheet.delegate =self;
//        sheet.tag =0;
//            [sheet showInView:self.view];
//            
//            
//            
//
//    }
//
//    if (indexPath.section==3) {
//        if (indexPath.row ==1) {
//            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"性别" otherButtonTitles:@"不详",@"男",@"女", nil];
//            sheet.delegate =self;
//            sheet.tag =1;
//            [sheet showInView:self.view];
//
//        }else if(indexPath.row ==2){
//            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"婚姻状态" otherButtonTitles:@"保密",@"未婚",@"已婚", nil];
//            sheet.delegate =self;
//            sheet.tag =2;
//            [sheet showInView:self.view];
//
//        }
//    }
//
//}

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

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
////    if (section==0||section==1) {
//        return 20;
////    }else
////    {
////        return 1;
////    }
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section==4) {
//        return 320;
//    }else
//    {
//        return 1;
//    }
//}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==4) {

//
//        UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.55, 0, _width*0.3, 50)];
//        price_L.numberOfLines=1;
//        price_L.text=@"已有账号，去";
//        price_L.textAlignment=NSTextAlignmentRight;
//        price_L.textColor=[UIColor darkGrayColor];
//        price_L.font=[UIFont systemFontOfSize:14];
//        [view addSubview:price_L];
//
//        UILabel*price_L1=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.85, 0, _width*0.13, 50)];
//        price_L1.numberOfLines=1;
//        price_L1.text=@"登录";
//        price_L1.textAlignment=NSTextAlignmentLeft;
//        price_L1.textColor=APP_ClOUR;
//        price_L1.font=[UIFont systemFontOfSize:14];
//        [view addSubview:price_L1];

        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 320)];
        view.backgroundColor=[UIColor whiteColor];


        _regBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _regBtn.frame=CGRectMake(0, 0, _width*0.1, 50);
        _regBtn.selected = YES;
//        [_logInBtn setBackgroundColor:APP_ClOUR];
        [_regBtn addTarget:self action:@selector(duihao:) forControlEvents:UIControlEventTouchUpInside];
        [_regBtn setImage:[UIImage imageNamed:@"jizhu1"] forState:UIControlStateNormal];
        [_regBtn setImage:[UIImage imageNamed:@"jizhu2"] forState:UIControlStateSelected];
        [_regBtn setImageEdgeInsets:UIEdgeInsetsMake(20,(_width*0.1-10), 20, (_width*0.1-10))];
        [view addSubview:_regBtn];

        UIButton*agreeMnetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString*atts=[[NSMutableAttributedString alloc]initWithString:@"我已看过并同意《天心庄园用户协议》"];
        [atts addAttribute:NSForegroundColorAttributeName value:APP_ClOUR range:NSMakeRange(7, 8)];
        [agreeMnetBtn setAttributedTitle:atts forState:UIControlStateNormal];
        agreeMnetBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        agreeMnetBtn.frame=CGRectMake(_width*0.1, 0, _width*0.8, 50);
        agreeMnetBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        [agreeMnetBtn addTarget:self action:@selector(useragreeMnetBtn) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:agreeMnetBtn];



       _logInBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _logInBtn.frame=CGRectMake(_width*0.05, 55, _width*0.9, 40);
        _logInBtn.tag=4;
        [_logInBtn setTitle:@"注册" forState:UIControlStateNormal];
//        _logInBtn.backgroundColor=[UIColor grayColor];
           [_logInBtn setBackgroundColor:APP_ClOUR];

        _logInBtn.titleLabel.font=[UIFont boldSystemFontOfSize:17];
        [_logInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_logInBtn addTarget:self action:@selector(logBtnBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _logInBtn.layer.cornerRadius=5;
        [view addSubview:_logInBtn];


        UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(0, 140, _width, 1)];
        hengxian.backgroundColor=RGB(234, 234, 234);
        [view addSubview:hengxian];




        return view;
    }else
    {
        return nil;
    }
}
-(void)useragreeMnetBtn
{

    webViewVC *webVC = [webViewVC new];
    webVC.url = [NSString stringWithFormat:@"%@/setUp/regs.action",BASE_URLL];
    webVC.whoPush = @"regiser";
[self presentViewController:webVC animated:YES completion:^{
}];

//    ALERT(@"用户协议");
}
-(void)duihao:(UIButton*)button
{
    if (button.selected) {
        button.selected=NO;
        [_logInBtn setBackgroundColor:[UIColor grayColor]];

    }else
    {
        [_logInBtn setBackgroundColor:APP_ClOUR];

        button.selected=YES;
    }

}
//-(void)registerbtnClick
//{
//    NSLog(@"登录");
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
//}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_phone_tf resignFirstResponder];
    [_password_tf resignFirstResponder];
    [_password_sure_tf resignFirstResponder];
    [_realName resignFirstResponder];
    [_niceName resignFirstResponder];
    [_identifierCode resignFirstResponder];
    [_email resignFirstResponder];
    

}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    [_phone_tf resignFirstResponder];
//    [_password_tf resignFirstResponder];
//    [_password_sure_tf resignFirstResponder];
//    [_niceName resignFirstResponder];
//    [_identifierCode resignFirstResponder];
//    [_email resignFirstResponder];
//}
-(void)logBtnBtnClick
{


    NSLog(@"zhece ");

    if (_regBtn.selected) {

    }else
    {
        return;
    }

//    NSString* birthday= [requestData GetBrithdayFromIdCard:_identifierCode.text];
//    NSData*data=UIImageJPEGRepresentation(_userFace.image, 1.0);
//    NSString *imageString=[data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//
//    NSDictionary *parameter = [NSDictionary dictionaryWithObjects:@[_phone_tf.text,_phoneCode.text,_niceName.text,_email.text,[sexDic objectForKey:_sexlab.text],birthday,_identifierCode.text,[marDic objectForKey:_marrayStatu.text]] forKeys:@[@"userId",@"password",@"nickName",@"email",@"sex",@"birthday",@"identityCard",@"maritalStatus"]];
//
//
//    NSLog(@"---para--%@",parameter);



    //NSLog(@"zhece ");
    [_phone_tf resignFirstResponder];
    [_password_tf resignFirstResponder];
    [_password_sure_tf resignFirstResponder];
    [_niceName resignFirstResponder];
    [_realName resignFirstResponder];
    [_identifierCode resignFirstResponder];
    [_email resignFirstResponder];

    if (![_password_tf.text isEqualToString:checkCode]) {
        return;
    }else{
        NSLog(@"++++++++++%@",checkCode);

    }


    if (_phone_tf.text.length==0) {
       // ALERT(@"请输入邮箱")
        MISSINGVIEW
        missing_v.tishi=@"请输入手机号码";
    }else
    {
        if (![requestData validateMobile:_phone_tf.text]) {
            //ALERT(@"输入邮箱格式不正确")
            MISSINGVIEW
            missing_v.tishi=@"手机号码格式不正确";

        }else
        {
            if (_password_tf.text.length==0) {
                MISSINGVIEW
                missing_v.tishi=@"密码不能为空";
               // ALERT(@"请输入密码")
            }else
            {
                if (_password_tf.text.length<6||_password_tf.text.length>18) {
                    MISSINGVIEW
                    missing_v.tishi=@"密码长度为6-18位";
                    //ALERT(@"密码长度为6-18位")
                }else
                {
                    if (_password_sure_tf.text.length==0) {
                        //ALERT(@"请输入确认密码")
                        MISSINGVIEW
                        missing_v.tishi=@"信息不完整";
                    }else
                    {
//                         NSLog(@"%@--%@",_phoneCode.text,_password_sure_tf.text);

                        if (![_phoneCode.text isEqualToString: _password_sure_tf.text]) {

                            MISSINGVIEW
                            missing_v.tishi=@"密码不匹配";
                           // ALERT(@"输入密码不匹配")
                        }else{
                            if (_niceName.text.length ==0) {
                                MISSINGVIEW
                                missing_v.tishi=@"请输入昵称";
                            }else{
                                if (_realName.text.length ==0) {
                                    MISSINGVIEW
                                    missing_v.tishi=@"请输入真实姓名";
                                }else{
                                    if (_identifierCode.text.length==0) {
                                        MISSINGVIEW
                                        missing_v.tishi =@"请输入有效身份证号码";
                                    }else{
                                        if (![requestData validateIdentityCard:_identifierCode.text]) {
                                            MISSINGVIEW
                                            missing_v.tishi =@"请输入有效身份证号码";

                                        }else{
                                            if (_email.text.length==0) {
                                                MISSINGVIEW
                                                missing_v.tishi =@"请输入邮箱";
                                            }else if (![requestData validateEmail:_email.text]){
                                                MISSINGVIEW
                                                missing_v.tishi =@"输入邮箱格式不正确";
                                            }else{

                               LOADVIEW
                            viewh.remind_L=@"正在提交数据";

     NSString*str=[NSString stringWithFormat:@"%@/users/regUsers.action?",BASE_URLL];

//           NSData *data = UIImagePNGRepresentation(_userFace.image);
       NSString* birthday= [requestData GetBrithdayFromIdCard:_identifierCode.text];
    AFHTTPRequestOperationManager*manger=[AFHTTPRequestOperationManager manager];
 NSData*data=UIImageJPEGRepresentation(_userFace.image, 1.0);
 NSString *imageString=[data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];


//         NSString *birthDayStr = [requestData GetBrithdayFromIdCard:_identifierCode.text];

   NSDictionary *parame = [NSDictionary dictionaryWithObjects:@[_phone_tf.text,_phoneCode.text,_niceName.text,_email.text,[sexDic objectForKey:_sexlab.text],imageString,birthday,_identifierCode.text,[marDic objectForKey:_marrayStatu.text]] forKeys:@[@"userId",@"password",@"nickName",@"email",@"sex",@"face",@"birthDay",@"identityCard",@"maritalStatus"]];


            NSLog(@"---para--%@",parame);


  manger.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
[manger POST:str parameters:parame success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             LOADREMOVE

       NSLog(@"---re--%@",responseObject);

         if ([[responseObject objectForKey:@"flag"] intValue]==1) {

             [self dismissViewControllerAnimated:YES completion:^{

                 ALLOC(logInVC)
                 [self presentViewController:vc animated:YES completion:^{
                 }];
             }];

             }else
                 {
                     MISSINGVIEW
                     missing_v.tishi=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"info"]];

                   }
                                                    
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   NSLog(@"错五%@",error);
                                                    
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

        }

    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==2&&indexPath.row==0) {
//            return 70;
//
//    }else
//    {
//        return 50;
//    }
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    UITableViewCell *cell = [[UITableViewCell alloc]init];
////    cell.selectionStyle= UITableViewCellSelectionStyleNone;
//
//    if (indexPath.section==0) {
//        if (indexPath.row==0||indexPath.row==1) {
//            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.4, 50)];
//            price_L.numberOfLines=1;
//            price_L.textAlignment=NSTextAlignmentCenter;
//            price_L.textColor=[UIColor darkGrayColor];
//            price_L.font=[UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:price_L];
//
//            if (indexPath.row==0) {
//                price_L.text=@"手机号码";
//
//                _phone_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
//                _phone_tf.placeholder=@"请输入手机号";
//                _phone_tf.keyboardType = UIKeyboardTypeNumberPad;
//                [_phone_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
//                _phone_tf.delegate=self;
//                _phone_tf.font=[UIFont systemFontOfSize:15];
//                [cell addSubview:_phone_tf];
//
//            }else if(indexPath.row==1)
//            {
////                price_L.text=@"验证码";
//                UIView*kuang=[[UIView alloc]initWithFrame:CGRectMake(_width*0.02, 8, _width*0.33, 34)];
//                kuang.layer.borderColor=[UIColor darkGrayColor].CGColor;
//                kuang.layer.borderWidth=1;
//                kuang.layer.cornerRadius=5;
//                [cell.contentView addSubview:kuang];
//                _testBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//                _testBtn.frame=CGRectMake(0, 0, _width*0.4, 50);
//                [_testBtn setTitle:@"获取验证码"forState:UIControlStateNormal];
//                [_testBtn setTitleColor:APP_ClOUR forState:UIControlStateNormal];
//                _testBtn.titleLabel.font=[UIFont systemFontOfSize:15];
//                [_testBtn addTarget:self action:@selector(testBtnClick) forControlEvents:UIControlEventTouchUpInside];
//                [_testBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, _width*0.05)];
//                [cell.contentView addSubview:_testBtn];
//
//                _password_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
//                _password_tf.placeholder=@"请输入验证码";
//                _password_tf.secureTextEntry=NO;
//                _password_tf.delegate=self;
//                _password_tf.keyboardType = UIKeyboardTypeNumberPad;
//
//                [_password_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
//                _password_tf.font=[UIFont systemFontOfSize:15];
//                [cell.contentView addSubview:_password_tf];
//
////                UIButton *getbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////                getbtn.frame= CGRectMake(_width*0.75, 5, _width*0.2, 40);
////                getbtn.backgroundColor =[UIColor redColor];
////                [cell.contentView addSubview:getbtn];
//            }
////            else
////            {
////                price_L.text=@"确认密码";
////                _password_sure_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
////                _password_sure_tf.placeholder=@"请输入确认密码";
////                [_password_sure_tf setValue:[UIFont boldSystemFontOfSize:15]
////                                 forKeyPath:@"_placeholderLabel.font"];
////                _password_sure_tf.delegate=self;
////                _password_sure_tf.secureTextEntry=YES;
////                _password_sure_tf.font=[UIFont systemFontOfSize:15];
////                [cell.contentView addSubview:_password_sure_tf];
////
////            }
//        }
//        UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.37, 5, 1, 40)];
//        shuxian.backgroundColor=RGB(234, 234, 234);
//        [cell.contentView addSubview:shuxian];
//    }else if (indexPath.section==1){
//        if (indexPath.row==0||indexPath.row==1) {
//            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width*0.4, 50)];
//            price_L.numberOfLines=1;
//            price_L.textAlignment=NSTextAlignmentCenter;
//            price_L.textColor=[UIColor darkGrayColor];
//            price_L.font=[UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:price_L];
//
//            if (indexPath.row==0) {
//                price_L.text=@"密码";
//
//                _phoneCode=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
//                _phoneCode.placeholder=@"请输入密码";
//                [_phoneCode setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
//                _phoneCode.delegate=self;
//                _phoneCode.secureTextEntry=YES;
//                _phoneCode.font=[UIFont systemFontOfSize:15];
//                [cell.contentView addSubview:_phoneCode];
//
//            }else if(indexPath.row==1)
//            {
//                price_L.text=@"确认密码";
//                _password_sure_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, 0, _width*0.57, 50)];
//                _password_sure_tf.placeholder=@"请再次输入密码";
//                _password_sure_tf.secureTextEntry=YES;
//                _password_sure_tf.delegate=self;
//                [_password_sure_tf setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
//                [_password_sure_tf setFont:[UIFont systemFontOfSize:15]];
//                [cell.contentView addSubview:_password_sure_tf];
//            }
//                   }
//        UIView*shuxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.37, 5, 1, 40)];
//        shuxian.backgroundColor=RGB(234, 234, 234);
//        [cell.contentView addSubview:shuxian];
//    }else if (indexPath.section==2){
//
//        if (indexPath.row==0) {
//            _userFace= [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10, 50, 50)];
//            _userFace.layer.cornerRadius=25;
//            _userFace.layer.masksToBounds=YES;
//            _userFace.image =[UIImage imageNamed:@"userFace"];
//            [cell.contentView addSubview:_userFace];
//            UILabel *Rlab = [[UILabel alloc]init];
//            Rlab.frame=CGRectMake(_width*0.7, 20, _width*0.94, 20);
//            Rlab.text = @"上传头像";
//            Rlab.textColor =[UIColor darkGrayColor];
//            Rlab.font =[UIFont systemFontOfSize:13];
//            [cell.contentView addSubview:Rlab];
//
//            UIImageView *Rimg=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 21, 18, 18)];
//            Rimg.image =[UIImage imageNamed:@"cp2"];
//            Rimg.transform =CGAffineTransformMakeRotation(M_PI*3/2);
//            [cell.contentView addSubview:Rimg];
//        }
//        if (indexPath.row==1) {
//            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.4, 50)];
//            price_L.text=@"昵称";
//            price_L.numberOfLines=1;
//            price_L.textAlignment=NSTextAlignmentLeft;
//            price_L.textColor=[UIColor darkGrayColor];
//            price_L.font=[UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:price_L];
//            _niceName = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.2, 0, _width*0.57, 50)];
//            _niceName.placeholder= @"请输入昵称";
//            _niceName.delegate=self;
//            _niceName.font = [UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:_niceName];
//            
//
//        }
//    }else if (indexPath.section ==3){
//        if (indexPath.row==0||indexPath.row==1||indexPath.row==2) {
//            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.4, 50)];
//            price_L.numberOfLines=1;
//            price_L.textAlignment=NSTextAlignmentLeft;
//            price_L.textColor=[UIColor darkGrayColor];
//            price_L.font=[UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:price_L];
//            if (indexPath.row==0) {
//                price_L.text=@"姓名";
//                _realName = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.2, 0, _width*0.57, 50)];
//                _realName.placeholder= @"请输入真实姓名";
//                _realName.delegate=self;
//                _realName.font = [UIFont systemFontOfSize:15];
//                [cell.contentView addSubview:_realName];
//            }else if (indexPath.row==1){
//                price_L.text=@"性别";
//                UIImageView *Rimg=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 16, 18, 18)];
//                Rimg.image =[UIImage imageNamed:@"cp2"];
//                Rimg.transform =CGAffineTransformMakeRotation(M_PI*3/2);
//                [cell.contentView addSubview:Rimg];
//                _sexlab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.2, 0, 50, 50)];
//                _sexlab.font = [UIFont systemFontOfSize:15];
//                _sexlab.textColor =[UIColor darkGrayColor];
//                _sexlab.text = @"不详";
//                [cell.contentView addSubview:_sexlab];
////                NSArray *sexArray = [[NSArray alloc]initWithObjects:@"男",@"女",@"保密", nil];
//
//            }else if (indexPath.row==2){
//                price_L.text=@"婚姻状态";
//                UIImageView *Rimg=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 16, 18, 18)];
//                Rimg.image =[UIImage imageNamed:@"cp2"];
//                Rimg.transform =CGAffineTransformMakeRotation(M_PI*3/2);
//                [cell.contentView addSubview:Rimg];
//                _marrayStatu = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, 0, 50, 50)];
//                _marrayStatu.textColor =[UIColor darkGrayColor];
//                _marrayStatu.text = @"保密";
//                _marrayStatu.font =[UIFont systemFontOfSize:15];
//                [cell.contentView addSubview: _marrayStatu];
//
//            }
//
//
//        }
//
//
//    }else if (indexPath.section==4){
//        if (indexPath.row==0||indexPath.row==1) {
//            UILabel*price_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.4, 50)];
//            price_L.numberOfLines=1;
//            price_L.textAlignment=NSTextAlignmentLeft;
//            price_L.textColor=[UIColor darkGrayColor];
//            price_L.font=[UIFont systemFontOfSize:15];
//            [cell.contentView addSubview:price_L];
//            if (indexPath.row==0) {
//                price_L.text=@"身份证号码";
//                _identifierCode = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.35, 0, _width*0.57, 50)];
//                _identifierCode.placeholder= @"请输入身份证号码";
//                _identifierCode.delegate=self;
//                _identifierCode.keyboardType= UIKeyboardTypeNumbersAndPunctuation;
//                _identifierCode.font = [UIFont systemFontOfSize:15];
//                [cell.contentView addSubview:_identifierCode];
//            }else if (indexPath.row==1){
//                price_L.text=@"电子邮件";
//                _email = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.35, 0, _width*0.57, 50)];
//                _email.placeholder= @"请输入电子邮件";
//                _email.delegate=self;
//                _email.keyboardType = UIKeyboardTypeEmailAddress;
//                _email.font = [UIFont systemFontOfSize:15];
//                [cell.contentView addSubview:_email];
//
//
//            }
//
//            
//        }
//        
//        
//    }
//    
//
//    
//    
//    return cell;
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
