//
//  setUserInfoVC.m
//  logRegister
//
//  Created by apple on 15-1-26.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "setUserInfoVC.h"

#import "setPassWordVC.h"


@interface setUserInfoVC ()

@end

@implementation setUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"修改用户信息")

    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64) style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    //_tableView.rowHeight=60;
    _tableView.bounces=YES;
    _tableView.scrollEnabled=YES;
    [self.view addSubview:_tableView];


    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(_width*0.02, 360, _width*0.96, 50);
    button.backgroundColor=APP_ClOUR;
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [_tableView addSubview:button];
    button.layer.cornerRadius=5;
    [self getdata];

    sexDic = [[NSDictionary alloc]initWithObjects:@[@"0",@"1",@"2"] forKeys:@[@"不详",@"男",@"女"]];
    marDic = [[NSDictionary alloc]initWithObjects:@[@"0",@"1",@"2"] forKeys:@[@"保密",@"未婚",@"已婚"]];
    fansexDic = [[NSDictionary alloc]initWithObjects:@[@"不详",@"男",@"女"] forKeys:@[@"0",@"1",@"2"]];
    fanmarDic = [[NSDictionary alloc]initWithObjects:@[@"保密",@"未婚",@"已婚"] forKeys:@[@"0",@"1",@"2"]];


    _tableView.keyboardDismissMode =UIScrollViewKeyboardDismissModeOnDrag;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyup:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyHide:) name:UIKeyboardWillHideNotification object:nil];




}

-(void)keyup:(NSNotification *)notice{

    NSValue *value = [notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];
    CGRect rect = [value CGRectValue];

    _tableView.frame = CGRectMake(0, 64, _width, _height-rect.size.height-64);
    [UIView commitAnimations];


}

-(void)keyHide:(NSNotification *)info{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:7];

    _tableView.frame = CGRectMake(0, 64, _width, _height-64)
    ;
    [UIView commitAnimations];
    
}

-(void)getdata
{
     [requestData getData:USER_INFO complete:^(NSDictionary *dic) {
         NSLog(@"%@",dic);
         _dataDic=[dic objectForKey:@"data"];
         [_tableView reloadData];
     }];
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_nickName_tf resignFirstResponder];
    [_email_tf resignFirstResponder];
//    [_identityCard_tf resignFirstResponder];

}
-(void)saveInfo
{
    [_nickName_tf resignFirstResponder];
    [_email_tf resignFirstResponder];

    AFHTTPRequestOperationManager*manger=[AFHTTPRequestOperationManager manager];
    NSString*str=[NSString stringWithFormat:@"%@/users/updateMessage.action?",BASE_URL];
    NSString*nickName;
    NSString*maritalStatus;
    NSString*sex;
    NSString*birthDay;
    NSString*identityCard;

    if (_nickName_tf.text.length==0) {

        nickName=@"";

    }else
    {
        nickName=_nickName_tf.text;

    }
    if (_maritalStatus_tf.text.length==0) {

        maritalStatus=@"";

    }else
    {
        maritalStatus=[marDic objectForKey:_maritalStatus_tf.text];
        
    }if (_sex_tf.text.length==0) {

        sex=@"";

    }else
    {
        sex= [sexDic objectForKey: _sex_tf.text ];
        
    }if (idString.length==0) {

        identityCard=@"";

    }else
    {
        identityCard=idString;
        
    }if (_birthDay_tf.text.length==0) {

        birthDay=@"";

    }else
    {
        birthDay=_birthDay_tf.text;
        
    }
    NSDictionary *parameter;
    NSData*data=UIImageJPEGRepresentation(_image, 1.0);
      _imageDataStr=[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];


    NSString*user;

    user=USERID;
    if (_email_tf.text.length!=0) {
        if ([requestData validateEmail:_email_tf.text]) {
            NSLog(@"faegstr");

        }else
        {

            MISSINGVIEW
            missing_v.tishi=@"邮箱格式不正确";
            return;
        }

    }
//    if (_identityCard_tf.text.length!=0) {
//        if ([requestData validateIdentityCard:_identityCard_tf.text]) {
//            NSLog(@"faegstr");
//
//        }else
//        {
//
//            MISSINGVIEW
//            missing_v.tishi=@"身份证格式不正确";
//            return;
//        }
//        
//    }


    if (_imageDataStr==nil) {
        NSLog(@"uuuuuuu");
        parameter=@{@"userId":user,@"nickName":nickName,@"email": _email_tf.text,@"sex":sex,@"birthDay":birthDay,@"identityCard":identityCard,@"maritalStatus":maritalStatus};

    }else
    {
        parameter=@{@"userId":user,@"nickName":nickName,@"email": _email_tf.text,@"sex":sex,@"birthDay":birthDay,@"identityCard":identityCard,@"maritalStatus":maritalStatus,@"face":_imageDataStr};

//        parameter=@{@"userId":user,@"nickName":nickName,@"email": _email_tf.text,@"face":_imageDataStr};

    }


    LOADVIEW
    viewh.remind_L=@"\t正在提交数据";

    manger.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
    [manger POST:str parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LOADREMOVE
        
//        NSLog(@"-----%@",responseObject);

        if ([[responseObject objectForKey:@"flag"] intValue]==1) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
            POP
            self.tabBarController.tabBar.hidden=YES;
//            ALERT([responseObject objectForKey:@"info"]);
        }else
        {
            MISSINGVIEW
            missing_v.tishi=[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"info"]];
//            ALERT([responseObject objectForKey:@"info"]);

        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 60;

    }else
    {
        return 40;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else
        return 3;


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];


    NSString* email=[_dataDic objectForKey:@"email"];
    if ((NSNull *)email==[NSNull null] ||email.length ==0) {
        email=nil;
    }
    id face=[_dataDic objectForKey:@"face"];
    if (face==[NSNull null]) {
        face=nil;
    }
    id nickName=[_dataDic objectForKey:@"nickName"];
    if (nickName==[NSNull null]) {
        nickName=nil;
    }
    id sex=[_dataDic objectForKey:@"sex"];
    if (sex==[NSNull null]) {
        sex=nil;
    }
    NSString* birthDay=[_dataDic objectForKey:@"birthDay"];
    if ((NSNull*)birthDay==[NSNull null]||birthDay.length ==0) {
        birthDay=nil;
    }
    NSString* identityCard=[_dataDic objectForKey:@"identityCard"];
    if ((NSNull*)identityCard==[NSNull null]||identityCard.length ==0) {
        identityCard=nil;
    }
    idString = identityCard;
    NSString* maritalStatus=[_dataDic objectForKey:@"maritalStatus"];
    if ((NSNull *)maritalStatus==[NSNull null]) {
        maritalStatus=nil;
    }


    if (indexPath.section==0) {

        UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 10, 40, 40)];


        if (face==nil) {
            imagev.image=[UIImage imageNamed:@"userFace"];
        }else
        {
            [imagev sd_setImageWithURL:[NSURL URLWithString:face] placeholderImage:[UIImage imageNamed:@"userFace"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            }];

        }
       // cell.imageView.frame=CGRectMake(_width*0.1, 10, 40, 40);
        imagev.layer.cornerRadius=20;
        imagev.clipsToBounds=YES;
        imagev.layer.borderWidth=1;
        imagev.layer.borderColor=RGB(234, 234, 234).CGColor;
        imagev.tag=80;
       [cell.contentView addSubview:imagev];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;


        UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05+50, 0, _width*0.45, 60)];
        nickName_L.text=@"更换用户头像";
        nickName_L.font=[UIFont systemFontOfSize:14];
        nickName_L.textAlignment=NSTextAlignmentLeft;
        [cell.contentView addSubview:nickName_L];



    }


    if (indexPath.section==1) {
        if (indexPath.row==0) {
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.2, 40)];

            nickName_L.text=@"昵称";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.17, 10, 1, 20)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];


            _nickName_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.2, 3, _width*0.8, 37)];
            _nickName_tf.delegate=self;
            if (nickName==nil) {
                _nickName_tf.placeholder=@"请输入昵称";
            }else
            {
                _nickName_tf.text=nickName;
            }

            [_nickName_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
            _nickName_tf.font=[UIFont systemFontOfSize:14];
            //        nickName_P.font=[UIFont systemFontOfSize:14];
            //        nickName_P.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:_nickName_tf];
        }else if(indexPath.row==1)
        {
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.2, 40)];

            nickName_L.text=@"邮箱";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.17, 10, 1, 20)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];


            _email_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.2, 3, _width*0.8, 37)];
            _email_tf.delegate=self;
            _email_tf.font=[UIFont systemFontOfSize:14];
            _email_tf.keyboardType = UIKeyboardTypeEmailAddress;
            if (email==nil) {
                _email_tf.placeholder=@"请输入邮箱";
            }else
            {
                 _email_tf.text=email;
            }

            [_email_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
            //        nickName_P.font=[UIFont systemFontOfSize:14];
            //        nickName_P.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:_email_tf];
        }else if (indexPath.row==2){
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.2, 40)];

            nickName_L.text=@"性别";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.17, 10, 1, 20)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];


            _sex_tf=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.2, 3, _width*0.8, 37)];
            _sex_tf.font=[UIFont systemFontOfSize:14];

            if (sex==nil) {
                _sex_tf.text=@"不详";

            }else
            {

                _sex_tf.text=fansexDic[[NSString stringWithFormat:@"%@",sex]];
            }

            [cell addSubview:_sex_tf];


        }

    }

    if (indexPath.section==2) {

    if(indexPath.row ==2){
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.2, 40)];

            nickName_L.text=@"生日";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.17, 10, 1, 20)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];


            _birthDay_tf=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.2, 3, _width*0.8, 37)];
            _birthDay_tf.font=[UIFont systemFontOfSize:14];
            if (birthDay==nil) {
//                _birthDay_tf.placeholder=@"请输入生日(如:1990-01-01)";
            }else
            {

                _birthDay_tf.text=birthDay;
            }
        [_birthDay_tf setFont:[UIFont systemFontOfSize:14]];
//            [_birthDay_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
            //        nickName_P.font=[UIFont systemFontOfSize:14];
            //        nickName_P.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:_birthDay_tf];


        }else if(indexPath.row ==0){
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.2, 40)];

            nickName_L.text=@"婚否";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.17, 10, 1, 20)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];


            _maritalStatus_tf=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.2, 3, _width*0.8, 37)];
            _maritalStatus_tf.font=[UIFont systemFontOfSize:14];

            if (maritalStatus==nil) {
                _maritalStatus_tf.text=@"保密";
            }else
            {

                _maritalStatus_tf.text=fanmarDic[[NSString stringWithFormat:@"%@",maritalStatus]];


//                NSLog(@"==婚姻=%@",fanmarDic[[NSString stringWithFormat:@"%@",maritalStatus]]);
            }

            [cell addSubview:_maritalStatus_tf];


        }else if(indexPath.row ==1){
            UILabel*nickName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 0, _width*0.2, 40)];

            nickName_L.text=@"身份证";
            nickName_L.font=[UIFont systemFontOfSize:14];
            nickName_L.textAlignment=NSTextAlignmentLeft;
            [cell addSubview:nickName_L];

            UIView*shuView=[[UIView alloc]initWithFrame:CGRectMake(_width*0.2, 10, 1, 20)];
            shuView.backgroundColor=RGB(234, 234, 234);
            [cell addSubview:shuView];


            _identityCard_tf=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.25, 3, _width*0.75, 37)];
//            _identityCard_tf.delegate=self;
            _identityCard_tf.font=[UIFont systemFontOfSize:14];
//            _identityCard_tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            _identityCard_tf.tag = indexPath.row;
            if (identityCard==nil ) {
//                _identityCard_tf.placeholder=@"请输入身份证";
            }else
            {
                NSString *string1= [identityCard substringToIndex:(identityCard.length-4)];

                _identityCard_tf.text=[NSString stringWithFormat:@"%@****",string1];
            }

//            [_identityCard_tf setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:_identityCard_tf];


        }

        }
    return cell;
}

//-(void)textFieldDidEndEditing:(UITextField *)textField{
//
//    if ((textField.tag ==1)) {
//        if (textField.text.length ==15 ||textField.text.length ==18) {
//            NSString* birthday= [requestData GetBrithdayFromIdCard:textField.text];
//
//            _birthDay_tf.text = birthday;
//
//        }
//    }
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField{

            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:textField.tag inSection:2];


            [_tableView scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
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
    if (indexPath.section==0) {

            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"拍照", nil];
        sheet.tag=0;
            [sheet showInView:self.view];



    }

    if (indexPath.section==1) {
        if (indexPath.row ==2) {
            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"性别" otherButtonTitles:@"不详",@"男",@"女", nil];
            sheet.delegate =self;
            sheet.tag =1;
            [sheet showInView:self.view];
        }
    }
    if(indexPath.section==2&&indexPath.row==0)
    {
            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"婚姻状态" otherButtonTitles:@"保密",@"未婚",@"已婚", nil];
            sheet.delegate =self;
            sheet.tag =2;
            [sheet showInView:self.view];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   

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
            }
    else if (actionSheet.tag==1){

        NSLog(@"buttonIndex==%ld",(long)buttonIndex);
        if (buttonIndex==1) {
            _sex_tf.text=@"不详";
        }
        if (buttonIndex==2) {
            _sex_tf.text=@"男";
        }
        if (buttonIndex==3) {
            _sex_tf.text=@"女";
        }

    }else{
        NSLog(@"buttonIndex==%ld",(long)buttonIndex);

        if (buttonIndex==1) {
            _maritalStatus_tf.text =@"保密";
        }
        if (buttonIndex==2) {
            _maritalStatus_tf.text =@"未婚";

        }
        if (buttonIndex==3) {
            _maritalStatus_tf.text =@"已婚";
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
        _image=image;
        //NSLog(@"%@",_imageDataStr);

    }];

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
