
//
//  orderbackVC.m
//  PsychiatricConsulting
//
//  Created by apple on 15/10/10.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "orderbackVC.h"

@interface orderbackVC ()
{
    SCREEN_WIDTH_AND_HEIGHT
    UIScrollView *scrollView;
    UITextView      *_contentText;
    UITextField     *_placeholderLabel;
    UILabel         *_number_L;
    NSMutableArray  *_imageArray;
    UILabel *explanation;
    myView          *_myView;
    UICollectionView    *_collectionView;
    UICollectionViewFlowLayout*_flowLayout;

    UIAlertView     *_alert;
    UIScrollView            *_downwardView;
    UILabel *state;
    UILabel *applayLab;
    UILabel *reason;
    NSArray *reasonArray;
    NSArray *applayArray;
    NSArray *stateArray;
    UIButton *applayback;
    UIButton *submission;
    CGFloat hh ;
}
@end

@implementation orderbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"申请退款")
    NSLog(@"==%@==",USERID);
    _imageArray = [[NSMutableArray alloc]init];
    reasonArray = [NSArray arrayWithObjects:@"缺货",@"未按预约时间发货",@"协商一致退款",@"拍错/多拍/不想要",@"其他", nil];
    applayArray = [NSArray arrayWithObjects:@"退款",@"换货", nil];
    stateArray = [NSArray arrayWithObjects:@"未收到货",@"已收到货", nil];

    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(_width, _height);
    [self.view addSubview:scrollView];

//    _orderState = @"1";

    _downwardView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+50, _width, 1)];
    _downwardView.scrollEnabled=YES;
//    _downwardView.backgroundColor=RGB(247, 247, 247);
    _downwardView.backgroundColor = [UIColor whiteColor];
    _downwardView.bounces=NO;


    UIButton *applayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    applayBtn.frame = CGRectMake(_width*0.02, 15, _width*0.96, 45);
    applayBtn.layer.borderColor = RGB(234, 234, 234).CGColor;
    applayBtn.layer.borderWidth= 1;
    [applayBtn addTarget:self action:@selector(xialaBtn:) forControlEvents:UIControlEventTouchUpInside];
    applayBtn.tag = 00;
    [scrollView addSubview:applayBtn];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.87, 14, 17, 17)];
    imgV.image = [UIImage imageNamed:@"cp2"];
    [applayBtn addSubview:imgV];

    UILabel *lab0 =[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 15, _width*0.5, 45)];
    lab0.text = @"申请服务";
    lab0.textColor = [UIColor lightGrayColor];
    lab0.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:lab0];


   applayLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, 15, _width*0.5, 45)];
    applayLab.text = applayArray[1];
    applayLab.textColor = [UIColor lightGrayColor];
    applayLab.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:applayLab];

//
//    if ([_orderState intValue]==1) {
//        applayBtn.enabled = NO;
        applayLab.text = @"退款";
        hh = 0;
        imgV.hidden = NO;
//    }else{
//        applayBtn.enabled = YES;
//        hh=64;
//        imgV.hidden = NO;
//
//
//        UIButton *cargoState = [UIButton buttonWithType:UIButtonTypeCustom];
//        cargoState.frame =CGRectMake(_width*0.02, 75, _width*0.96, 45);
//        cargoState.layer.borderColor = RGB(234, 234, 234).CGColor;    cargoState.layer.borderWidth= 1;
//        [cargoState addTarget:self action:@selector(xialaBtn:) forControlEvents:UIControlEventTouchUpInside];
//        cargoState.tag = 11;
//        [scrollView addSubview:cargoState];
//        UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.87, 14, 17, 17)];
//        imgV1.image = [UIImage imageNamed:@"cp2"];
//        [cargoState addSubview:imgV1];
//
//        state = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, 75, _width*0.8, 45)];
//        state.text = @"请选择货物状态";
//        state.textColor = [UIColor lightGrayColor];
//        state.font = [UIFont systemFontOfSize:15];
//        [scrollView addSubview:state];
//        UILabel *lab1 =[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 75, _width*0.5, 45)];
//        lab1.text = @"货物状态";
//        lab1.textColor = [UIColor lightGrayColor];
//        lab1.font = [UIFont systemFontOfSize:15];
//        [scrollView addSubview:lab1];



//    }



    applayback = [UIButton buttonWithType:UIButtonTypeCustom];
    applayback.frame =CGRectMake(_width*0.02, 75+hh, _width*0.96, 45);
    applayback.layer.borderColor = RGB(234, 234, 234).CGColor;    applayback.layer.borderWidth= 1;
    [applayback addTarget:self action:@selector(xialaBtn:) forControlEvents:UIControlEventTouchUpInside];
    applayback.selected = YES;
    applayback.tag = 22;
    [scrollView addSubview:applayback];
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.87, 14, 17, 17)];
    imgV2.image = [UIImage imageNamed:@"cp2"];
    [applayback addSubview:imgV2];

    reason = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, 75+hh, _width*0.8, 45)];
    reason.text = @"请选择退款/换货原因";
    reason.textColor = [UIColor lightGrayColor];
    reason.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:reason];

    UILabel *lab2 =[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 75+hh, _width*0.5, 45)];
    lab2.text = @"退/换原因";
    lab2.textColor = [UIColor lightGrayColor];
    lab2.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:lab2];


    UIButton *applayamount = [UIButton buttonWithType:UIButtonTypeCustom];
    applayamount.frame = CGRectMake(_width*0.02, 135+hh, _width*0.96, 45);
    applayamount.layer.borderColor = RGB(234, 234, 234).CGColor;    applayamount.layer.borderWidth= 1;
    [scrollView addSubview:applayamount];

    UILabel *amount = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 135+hh, _width*0.9, 45)];
    amount.text = [NSString stringWithFormat:@"退款金额   ¥%.2f",[_realPrice doubleValue]];
    amount.textColor = [UIColor lightGrayColor];
    amount.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:amount];

    explanation  =[[UILabel alloc]initWithFrame:CGRectMake(_width*0.02, 190+hh, _width*0.5, 30)];
    explanation.text = @"退款说明";
    explanation.font = [UIFont systemFontOfSize:16];
    explanation.textColor = [UIColor blackColor];
    explanation.hidden = YES;
    [scrollView addSubview:explanation];

    _contentText=[[UITextView alloc]initWithFrame:CGRectMake(_width*0.02, 230+hh, _width*(1-0.02*2), 150)];
    _contentText.delegate=self;
    _contentText.layer.borderWidth = 1;
    _contentText.layer.borderColor = RGB(234, 234, 234).CGColor;
    _contentText.font = [UIFont systemFontOfSize:13];
    _contentText.hidden = YES;
    [scrollView addSubview:_contentText];

    _placeholderLabel=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.06, 235+hh, _width*0.94-20, 20)];
    _placeholderLabel.placeholder=@"输入退款/换货说明，最多200字";
    _placeholderLabel.textAlignment=NSTextAlignmentLeft;
    _placeholderLabel.font=[UIFont systemFontOfSize:14];
    [_placeholderLabel setEnabled:NO];
    _placeholderLabel.textColor=RGB(150, 150, 150);
    _placeholderLabel.hidden =YES;
    [scrollView addSubview:_placeholderLabel];


    _number_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.75, 355+hh, _width*0.2, 20)];
    _number_L.text=@"200/200";
    _number_L.hidden = YES;
    _number_L.textAlignment=NSTextAlignmentRight;
    _number_L.font=[UIFont italicSystemFontOfSize:12];
    _number_L.textColor=RGB(100, 100, 100);
    [scrollView addSubview:_number_L];




//
//    _flowLayout=[[UICollectionViewFlowLayout alloc]init];
//    _flowLayout.itemSize=CGSizeMake(_width*0.28, _width*0.28);
//    _flowLayout.minimumLineSpacing=_width*0.04;
//    _flowLayout.minimumInteritemSpacing=_width*0.02;
//    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//
//    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(_width*0.02, 420+hh, _width*0.96, _width*0.28) collectionViewLayout:_flowLayout];
//    _collectionView.delegate=self;
//    _collectionView.dataSource=self;
//
//    _collectionView.backgroundColor=[UIColor whiteColor];
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    _collectionView.scrollEnabled=NO;
//    [scrollView addSubview:_collectionView];


     submission = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.05, 200+hh, _width*0.9, 44)];
    submission.backgroundColor = APP_ClOUR;
    [submission setTitle:@"提交申请" forState:UIControlStateNormal];
    [submission setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submission.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [submission addTarget:self action:@selector(submitInfo:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:submission];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_imageArray.count>=2 ) {
        return 3;
    }else
        return _imageArray.count+1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row==_imageArray.count) {
        UIButton*addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.tag=indexPath.row;
        addBtn.backgroundColor=[UIColor whiteColor];

        UIImageView*addIv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width*0.28, _width*0.28)];
        addIv.image=[UIImage imageNamed:@"上传凭证"];
        [addBtn addSubview:addIv];

        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.frame=CGRectMake(0, 0, _width*0.28, _width*0.28);

        [cell.contentView addSubview:addBtn];

    }else
    {
        UIButton*addBtn=[UIButton buttonWithType:UIButtonTypeCustom];

        [addBtn setBackgroundImage:[_imageArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        addBtn.tag=indexPath.row;

        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.23, 0, _width*0.05, _width*0.05);
        [button setTitle:@"X" forState:UIControlStateNormal];
        button.tag=indexPath.row;
        [button addTarget:self action:@selector(minClick:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn addSubview:button];

        // [addBtn addTarget:self action:@selector(minClick:) forControlEvents:UIControlEventTouchUpInside];



        addBtn.frame=CGRectMake(0, 0, _width*0.28, _width*0.28);

        [cell.contentView addSubview:addBtn];
        
        
    }
    
    
    
    return cell;
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{ if(actionSheet.tag==22){
    if (buttonIndex==0) {

        QBImagePickerController*vc=[[QBImagePickerController alloc]init];
        vc.delegate=self;
        vc.allowsMultipleSelection=YES;
        vc.maximumNumberOfSelection=3;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:navigationController animated:YES completion:NULL];


    }
    if (buttonIndex==1) {
        UIImagePickerController*pc=[[UIImagePickerController alloc]init];
        pc.delegate=self;
        pc.allowsEditing=YES;
        pc.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pc animated:YES completion:^{

        }];

    }
    if (buttonIndex==2) {
        
        
    }
}

    if (actionSheet.tag ==0) {

      if(buttonIndex==2){
      }else{
          applayLab.text =applayArray[buttonIndex];

      }
    }

    if (actionSheet.tag==11) {
        if(buttonIndex==2){
        }else{
            state.text =stateArray[buttonIndex];

        }    }

}
- (void)dismissImagePickerController
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popToViewController:self animated:YES];
    }
}


#pragma mark - QBImagePickerControllerDelegate

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset
{
    //    NSLog(@"*** imagePickerController:didSelectAsset:");
    //    NSLog(@"%@", asset);

    [self dismissImagePickerController];
}

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    //NSLog(@"*** imagePickerController:didSelectAssets:");


    for (int i=0; i<assets.count; i++) {
        id all=[assets objectAtIndex:i];
        if ([all isKindOfClass:[UIImage class]]) {
            UIImage*image=[assets objectAtIndex:i];
            [_imageArray addObject:image];
        }else
        {
            if ([[all valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                CGImageRef ratio=[all aspectRatioThumbnail];
                UIImage*image=[UIImage imageWithCGImage:ratio];
                [_imageArray addObject:image];

            }
        }
    }
    // NSLog(@"drtfvghbjklm----%d",_imageArray.count);
    [_collectionView reloadData];

    [self dismissImagePickerController];
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    //NSLog(@"*** imagePickerControllerDidCancel:");

    [self dismissImagePickerController];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{

        //        NSLog(@"照相机");

        [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage*image=[info objectForKey:UIImagePickerControllerEditedImage];
        [_imageArray addObject:image];
        [_collectionView reloadData];
        
        
    }];
    
}

-(void)minClick:(UIButton*)button
{
    //NSLog(@"%ldd----%d",(long)button.tag,_imageArray.count);
    if (button.tag<_imageArray.count) {
        //NSLog(@"%ldd----%d",(long)button.tag,_imageArray.count);
        [_imageArray removeObjectAtIndex:button.tag];
        [_collectionView reloadData];
    }
    //    NSLog(@"======%@",_imageArray);
    
    
}

-(void)addClick:(UIButton*)button
{

    [_contentText resignFirstResponder];

    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相册选取" otherButtonTitles:@"拍照", nil];
    sheet.tag=22;

    [sheet showInView:self.view];
    
    
    
    
}

-(void)textViewDidChange:(UITextView *)textView{
    _number_L.text=[NSString stringWithFormat:@"%lu/200",200-textView.text.length];
    if (_contentText.text.length>200) {
        MISSINGVIEW
        missing_v.tishi=@"字数受限";
        _number_L.text=@"0";

        return;

    }
    _placeholderLabel.hidden = YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{



    if (![text isEqualToString:@""])

    {
        _placeholderLabel.hidden = YES;

    }

    if ([text isEqualToString:@""] && range.location == 1 && range.length == 1)

    {

        _placeholderLabel.hidden = NO;
        
    }
    
    return YES;
}

-(void)submitInfo:(UIButton*)sender{

    [_contentText resignFirstResponder];
    NSString *returnType;
    if ([applayArray indexOfObject:applayLab.text]==0) {
        returnType =@"2";
    }else{
        returnType =@"1";

    }

    NSString *yuanyin =reason.text;



    if ([reason.text isEqualToString:@"请选择退款/换货原因"]) {
        MISSINGVIEW
        missing_v.tishi = [NSString stringWithFormat:@"请选择%@原因",applayLab.text] ;
    }else if ([reason.text isEqualToString:@"其他"]&&_contentText.text.length==0) {
        MISSINGVIEW
        missing_v.tishi = [NSString stringWithFormat:@"请填写%@原因",applayLab.text] ;
    }else {
        if (_contentText.text.length!=0) {
            yuanyin = _contentText.text;
        }
        NSLog(@"+++++++++++%@===%@====%@==%@==%@",USERID, self.productId, self.orderNo, returnType, yuanyin);

        [requestData getData:ORDER_BACK_URL(USERID, self.productId, self.orderNo, returnType, yuanyin) complete:^(NSDictionary *dic) {

            MISSINGVIEW
            missing_v.tishi =dic[@"info"];


            if ([dic[@"flag"]integerValue]==1) {
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.5f];
            }
            //
            //            NSString*topicsId=[dic objectForKey:@"topicsId"];
            //
            //
            //            NSInteger imgcount =0;
            //            if (_imageArray==nil) {
            //                imgcount=1;
            //            }else{
            //                imgcount=_imageArray.count;
            //            }
            //
            //
            //
            //            for (int i=0; i<imgcount; i++) {
            //
            //                NSData*data;
            //                if (_imageArray==nil) {
            //                    data=nil;
            //                }else{
            //                    data=UIImagePNGRepresentation([_imageArray objectAtIndex:i]);
            //
            //                }
            //                NSString *string=[data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
            //
            //
            //                AFHTTPRequestOperationManager*manger=[AFHTTPRequestOperationManager manager];
            //
            //                NSString*str=[NSString stringWithFormat:@"%@/topics/add.action?" ,BASE_URLL];
            //
            //                NSDictionary *parameter=@{@"topicsId":topicsId,@"imgSize":[NSString stringWithFormat:@"%lu",(unsigned long)_imageArray.count],@"linkImagePath": string};
            //
            //
            //                manger.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
            //
            //                _myView=[[myView alloc]initWithFrame:self.view.frame];
            //                _myView.backgroundColor=[UIColor clearColor];
            //
            //
            //                _myView.remind_L=@"\t正在提交数据";
            //                [self.view addSubview:_myView];
            //
            //                [manger POST:str parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            //
            //                    if ([[responseObject objectForKey:@"flag"] intValue]==1) {
            //
            //                        [self performSelector:@selector(yanshipop) withObject:nil afterDelay:0.5];
            //                        
            //                    }
            //                    
            //                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //                    //                NSLog(@"??????/%@",error);
            //                    _alert.message=@"网络繁忙，请稍后再试。";
            //                    
            //                }];
            //                
            //            }
            
        }];
    }




    
}
- (void)delayMethod {
POP

}

-(void)yanshipop
{
    //    NSLog(@"111111111111111111");

    [_myView removeFromSuperview];
    //    self.tabBarController.tabBar.hidden=NO;
//    PUSH(personCenter)
}

-(void)backClick{
    POP
}
#pragma mark下拉框

-(void)xialaBtn:(UIButton*)button{
//    NSLog(@"button.selected==%d===%ld",button.selected,button.tag);

    if (button.tag ==0) {
        UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:applayArray[0] otherButtonTitles:applayArray[1], nil];
        sheet.tag=00;

        [sheet showInView:self.view];

    }else if (button.tag ==11){
        UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:stateArray[0] otherButtonTitles:stateArray[1], nil];
        sheet.tag=11;

        [sheet showInView:self.view];
  }

    if (button.tag==22){
        if (button.selected ==YES) {

            [UIView animateWithDuration:0.3 animations:^{
                _downwardView.frame=CGRectMake(0, 135+hh, _width,_height*1.5);
                button.selected = NO;

                        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];

                        btn.frame=CGRectMake(0, 2, _width, 45);
                        [btn  setTitle:[NSString stringWithFormat:@"\t%@",@"请选择退款/退货原因"] forState:UIControlStateNormal];
                        btn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;

                        btn.titleLabel.font=[UIFont systemFontOfSize:15];
                        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        [_downwardView addSubview:btn];

                        UIView*line=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05, 45, _width, 1)];
                        line.backgroundColor=RGB(230, 230, 230);
                        [btn addSubview:line];
                        UIView*line0=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
                        line0.backgroundColor=[UIColor lightGrayColor];
                        [_downwardView addSubview:line0];

                        UIView*line1=[[UIView alloc]initWithFrame:CGRectMake(0, 8*45, _width, 1)];
                        line1.backgroundColor=[UIColor lightGrayColor];
                        [_downwardView addSubview:line1];


                        for (int i=0; i<reasonArray.count; i++) {

                            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];

                            button.frame=CGRectMake(0, 47+45*i, _width, 45);
                            UIView*line=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05, 44, _width, 1)];
                            line.backgroundColor=RGB(230, 230, 230);
                            [button addSubview:line];

                            [button  setTitle:[NSString stringWithFormat:@"\t%@",reasonArray[i]] forState:UIControlStateNormal];
                            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                            [button setTitleColor:APP_ClOUR forState:UIControlStateSelected];
                            button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
                            //            button.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.6];
                            //        button.backgroundColor=RGB(244, 244, 244);

                            [_downwardView addSubview:button];
                            button.tag=i;
                            button.titleLabel.font=[UIFont systemFontOfSize:15];

                            [button addTarget:self action:@selector(xialaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                            
                        }
                        
                        [scrollView addSubview:_downwardView];
                        

                    




            } completion:^(BOOL finished) {

            }];
       }else{
            for (UIView*view in _downwardView.subviews) {
                [view removeFromSuperview];
            }
            _downwardView.frame=CGRectMake(0, 64+50, _width, 0);
            button.selected = YES;

        }

    }


    
}

-(void)xialaBtnClick:(UIButton*)button
{
    for (UIView*Btn in [button superview].subviews) {
        if ([Btn isKindOfClass:[UIButton class]]) {
            UIButton*allBtn=(UIButton*)Btn;
            allBtn.selected=NO;
        }
    }
    button.selected=YES;


    for (UIView*view in _downwardView.subviews) {
        [view removeFromSuperview];
    }



    [UIView animateWithDuration:0.2 animations:^{
        _downwardView.frame=CGRectMake(0, 64+50, _width, 0);
        reason.text = reasonArray[button.tag];
        if (button.tag ==4) {
            submission.frame =CGRectMake(_width*0.05, 460+hh, _width*0.9, 44);
            explanation.hidden = NO;
            _placeholderLabel.hidden = NO;
            _contentText.hidden = NO;
            _number_L.hidden = NO;
        }else{
            submission.frame =CGRectMake(_width*0.05, 200+hh, _width*0.9, 44);
            explanation.hidden = YES;
            _placeholderLabel.hidden = YES;
            _contentText.hidden = YES;
            _number_L.hidden = YES;

        }

    } completion:^(BOOL finished) {


    }];


}




-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_contentText resignFirstResponder];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
