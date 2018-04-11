//
//  pubStoryVC.m
//  logRegister
//
//  Created by apple on 15-1-29.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "pubStoryVC.h"

#import "mystoryVC.h"
#import "SQFLViewController.h"
#import "ShequViewController.h"
#import "Modle.h"
#import "personCenter.h"
@interface pubStoryVC ()

@end

@implementation pubStoryVC

-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;

    NSLog(@"===%@",self.classlab);
    if (self.classlab ==nil||[self.classlab isEqualToString:@"请选择分类"]) {
        self.classlab =@"请选择分类";

        Rlab.frame=CGRectMake(_width*0.65, 12, _width*0.94, 20);

    }else{
        Rlab.frame=CGRectMake(_width*0.75, 12, _width*0.94, 20);

    }
    Rlab.text=self.classlab;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
      return NO;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{

    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"发布话题")


    self.view.backgroundColor=RGB(234, 234, 234);
    UIButton *surebtn=[UIButton buttonWithType:UIButtonTypeSystem];
    surebtn.frame=CGRectMake(_width-64, 20, 64, 40) ;
    [surebtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    [surebtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [surebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    surebtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    surebtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [surebtn addTarget:self action:@selector(sureclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:surebtn];

    _imageArray=[[NSMutableArray alloc]init];

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.delegate=self;
    _scrollView.bounces=YES;
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize=CGSizeMake(_width, _height);
    [self.view addSubview:_scrollView];
//    _scrollView .backgroundColor = [UIColor redColor];
    UIButton *Bview = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _width, 44)];
    Bview.backgroundColor =[UIColor whiteColor];
    [Bview addTarget:self action:@selector(classbutton) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:Bview];


    UILabel *classLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.036, 12, _width*0.94, 20)];
    classLab.text=@"分类";
    classLab.textColor=[UIColor darkGrayColor];
    classLab.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:classLab];

    Rlab = [[UILabel alloc]init];
    if (self.classlab ==nil) {
        self.classlab =@"请选择分类";

        Rlab.frame=CGRectMake(_width*0.65, 12, _width*0.94, 20);

//        self.interactiveId =@"7";
    }else{
        Rlab.frame=CGRectMake(_width*0.75, 12, _width*0.94, 20);

    }
    Rlab.text=self.classlab;
    Rlab.textColor=[UIColor darkGrayColor];
    Rlab.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:Rlab];

    UIImageView *Rimg=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.9, 12, 20, 20)];
    Rimg.image =[UIImage imageNamed:@"cp2"];
    Rimg.transform =CGAffineTransformMakeRotation(M_PI*3/2);
    [_scrollView addSubview:Rimg];


    titletext = [[UITextField alloc]initWithFrame:CGRectMake(_width*0.03+44, 44+10, _width-44-_width*0.03*2, 44)];
    titletext.backgroundColor = [UIColor whiteColor];
    titletext.font = [UIFont systemFontOfSize:15];
    titletext.delegate=self;
//    [titletext resignFirstResponder];
    UILabel*mainlab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 44+10, 44, 44)];
    mainlab.text = @"话题";
    mainlab.textColor =[UIColor darkGrayColor];
    mainlab.textAlignment= NSTextAlignmentCenter;
    mainlab.backgroundColor =[UIColor whiteColor];
    mainlab.font =[UIFont systemFontOfSize:15];
    [_scrollView addSubview:mainlab];

    [_scrollView addSubview:titletext];
    


    _contentText=[[UITextView alloc]initWithFrame:CGRectMake(_width*0.03, 44+10+44+10, _width*(1-0.03*2), 150)];
    _contentText.delegate=self;
    _contentText.font = [UIFont systemFontOfSize:15];
    [_scrollView addSubview:_contentText];

    _placeholderLabel=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.036, 113, _width*0.94-20, 20)];
    _placeholderLabel.placeholder=@"说点什么吧！";
    _placeholderLabel.textAlignment=NSTextAlignmentLeft;
    _placeholderLabel.font=[UIFont systemFontOfSize:14];
    [_placeholderLabel setEnabled:NO];
    _placeholderLabel.textColor=RGB(150, 150, 150);
    [_scrollView addSubview:_placeholderLabel];



//    _number_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.7, 108+125, _width*0.2, 20)];
//    _number_L.text=@"150/150";
//    _number_L.textAlignment=NSTextAlignmentRight;
//    _number_L.font=[UIFont italicSystemFontOfSize:12];
//    _number_L.textColor=RGB(100, 100, 100);
//    [_scrollView addSubview:_number_L];



    _flowLayout=[[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize=CGSizeMake(_width*0.28, _width*0.28);
    _flowLayout.minimumLineSpacing=_width*0.04;
    _flowLayout.minimumInteritemSpacing=_width*0.02;
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];

    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 108+160, _width, _height) collectionViewLayout:_flowLayout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;

    _collectionView.backgroundColor=[UIColor whiteColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.scrollEnabled=NO;
    [_scrollView addSubview:_collectionView];



}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_contentText resignFirstResponder];
    [titletext resignFirstResponder];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{


    if (_imageArray.count+1>6 &&_imageArray.count+1<10) {
        _scrollView.contentSize=CGSizeMake(_width, _height+64);
    }
    if (_imageArray.count+1>3&&_imageArray.count+1<7) {
        _scrollView.contentSize=CGSizeMake(_width, _height);
    }
    if (_imageArray.count+1>0&&_imageArray.count+1<4) {
            }
    if (_imageArray.count>=9) {
         _scrollView.contentSize=CGSizeMake(_width, _height+64+(_width*0.28)*(_imageArray.count-8));
        _collectionView.frame=CGRectMake(0, 160+108, _width, _height+64+(_width*0.28)*(_imageArray.count-8));
    }
    if (_imageArray.count>=9) {
        return 9;
    }else{
        return _imageArray.count+1;

    }

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];


    NSLog(@"++++++%ld+++++++%lu",(long)indexPath.row,(unsigned long)_imageArray.count);
    if (indexPath.row==_imageArray.count) {
        UIButton*addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        addBtn.layer.borderWidth=1;
        addBtn.backgroundColor=[UIColor whiteColor];
        addBtn.layer.borderColor=RGB(220, 220, 220).CGColor;
        addBtn.tag=indexPath.row;
        //NSLog(@"hh");
        UIImageView*addIv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.04, _width*0.04, _width*0.2, _width*0.2)];
        addIv.image=[UIImage imageNamed:@"bigplus"];
        [addBtn addSubview:addIv];

        [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        addBtn.frame=CGRectMake(0, 0, _width*0.28, _width*0.28);
        
        [cell.contentView addSubview:addBtn];
        if (_imageArray.count>=9) {
            addBtn.hidden = YES;
        }

    }else
    {
        UIButton*addBtn=[UIButton buttonWithType:UIButtonTypeCustom];

        [addBtn setBackgroundImage:[_imageArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        addBtn.tag=indexPath.row;

        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.23, 0, _width*0.05, _width*0.05);
        [button setTitle:@"X" forState:UIControlStateNormal];
        button.tag=indexPath.row;
//        [button addTarget:self action:@selector(minClick:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn addSubview:button];

               // [addBtn addTarget:self action:@selector(minClick:) forControlEvents:UIControlEventTouchUpInside];



        addBtn.frame=CGRectMake(0, 0, _width*0.28, _width*0.28);

        [cell.contentView addSubview:addBtn];

        UIButton *mimbtn = [UIButton buttonWithType:UIButtonTypeSystem];
        mimbtn.frame = CGRectMake(_width*0.1, 0, _width*0.18, _width*0.18);
        mimbtn.tag = indexPath.row;
        [mimbtn addTarget:self action:@selector(minClick:) forControlEvents:UIControlEventTouchUpInside];
        [addBtn addSubview:mimbtn];

    }



    return cell;

}
-(void)minClick:(UIButton*)button
{
    NSLog(@"%ldd----%lu",(long)button.tag,(unsigned long)_imageArray.count);
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

    [sheet showInView:self.view];




}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {

        NSLog(@"===%lu",(unsigned long)_imageArray.count);
        QBvc=[[QBImagePickerController alloc]init];
        QBvc.delegate=self;
        QBvc.allowsMultipleSelection=YES;
        if (_imageArray.count==0) {
            QBvc.maximumNumberOfSelection=9;
        }else{
            QBvc.maximumNumberOfSelection=9-_imageArray.count;

        }
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:QBvc];
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
    NSLog(@"*** imagePickerController:didSelectAsset:");
    NSLog(@"%@", asset);

    [self dismissImagePickerController];
}

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets
{
    NSLog(@"*** imagePickerController:didSelectAssets:====%lu",(unsigned long)assets.count);

        for (int i=0; i<assets.count; i++) {
            id all=[assets objectAtIndex:i];
            if ([all isKindOfClass:[UIImage class]]) {
                UIImage*image=[assets objectAtIndex:i];
                if (_imageArray.count<9) {
                    [_imageArray addObject:image];


                }

            }else
            {
                if ([[all valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    CGImageRef ratio=[all aspectRatioThumbnail];
                    UIImage*image=[UIImage imageWithCGImage:ratio];

                    if (_imageArray.count<9) {
                        [_imageArray addObject:image];
                        
                    }

                }
            }

//            NSLog(@"+++++++%ld",_imageArray.count);

        }



//    NSLog(@"drtfvghbjklm----%lu",(unsigned long)_imageArray.count);
    [_collectionView reloadData];

    [self dismissImagePickerController];
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"*** imagePickerControllerDidCancel:");

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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{




}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(_width*0.04,_width*0.04, _width*0.04,_width*0.04);
}

-(void)sureclick{

    [_contentText resignFirstResponder];
    if(self.interactiveId==nil){
        MISSINGVIEW
        missing_v.tishi=@"请选择分类";

    }else if (titletext.text.length==0) {
        MISSINGVIEW
        missing_v.tishi=@"请输入话题标题";
    }else if (_contentText.text.length==0){
        MISSINGVIEW
        missing_v.tishi=@"请输入话题内容";

    }else if (_imageArray.count==0){
         MISSINGVIEW
          missing_v.tishi=@"请添加话题图片";

    }else{




            NSInteger imgcount =0;
            if (_imageArray==nil) {
                imgcount=1;
            }else{
                imgcount=_imageArray.count;
            }


        NSString *Tatledatastring;

            for (int i=0; i<imgcount; i++) {

                NSData*data;
                if (_imageArray==nil) {
                    data=nil;
                }else{
                    data = UIImageJPEGRepresentation([_imageArray objectAtIndex:i], 0.5);

                }
                if (_imageArray.count>1) {

                    NSString *dataString =[data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

                    if (Tatledatastring.length ==0) {
                        Tatledatastring =dataString;
                    }else{
                        Tatledatastring = [NSString stringWithFormat:@"%@|%@",Tatledatastring,dataString];

                    }

                }else{
                    Tatledatastring=[data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

                }


            }

                AFHTTPRequestOperationManager*manger=[AFHTTPRequestOperationManager manager];

        NSLog(@"========%ld=======%@",_imageArray.count,Tatledatastring);
                NSString*str=[NSString stringWithFormat:@"%@/topics/adds.action?" ,BASE_URLL];
                NSDictionary *parameter=@{@"topicsTitle":titletext.text,@"LinkImagePath": Tatledatastring,@"userId":USERID,@"topicsContent":_contentText.text,@"interactiveId":self.interactiveId};

                manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript", nil];

//        manger.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manger.responseSerializer = [AFHTTPResponseSerializer serializer];

                _myView=[[myView alloc]initWithFrame:self.view.frame];
                _myView.backgroundColor=[UIColor clearColor];


                _myView.remind_L=@"\t正在提交数据";
                [self.view addSubview:_myView];

                [manger POST:str parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {

//                    NSData *doubi = responseObject;
//                    NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
//                    
                    NSLog(@"-responseObject-%@",responseObject);


                    if ([[responseObject objectForKey:@"flag"] intValue]==1) {

                        MISSINGVIEW
                        missing_v.tishi = [NSString stringWithFormat:@"%@,积分+%@",responseObject[@"info"],responseObject[@"Score"]];

                        [self performSelector:@selector(yanshipop) withObject:nil afterDelay:1];
                        
                        
                        
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"??????/%@",error);
                    _alert.message=@"网络繁忙，请稍后再试。";
                    [_denglu removeFromSuperview];
                    
                }];
                


    }

}

-(void)yanshipop
{


    NSLog(@"++++++%@",self.view.subviews);



    [_myView removeFromSuperview];

  //    self.tabBarController.tabBar.hidden=NO;
    POP


//    for (UIViewController *controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[personCenter class]]) {
//            [self.navigationController popToViewController:controller animated:YES];
//        }
//    }


//    PUSH(personCenter)

    [self removeFromParentViewController];

}
-(void)textViewDidChange:(UITextView *)textView
{
//    _number_L.text=[NSString stringWithFormat:@"%lu/150",150-textView.text.length];
//    if (_contentText.text.length>150) {
//        MISSINGVIEW
//        missing_v.tishi=@"字数受限";
//        _number_L.text=@"0";
//
//        return;
//
//    }
    _placeholderLabel.hidden = YES;


}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
   // _placeholderLabel.hidden = YES;
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
-(void)backClick
{
    if ([self.whoPush isEqualToString:@"myself"]) {
        POP

        self.tabBarController.tabBar.hidden=YES;
    }else
    {
        POP

//        PUSH(personCenter)
//        self.tabBarController.tabBar.hidden=NO;
    }

}

-(void)classbutton{

//    [requestData getData:APP_URLL complete:^(NSDictionary *dic) {
//        NSMutableArray *array = [[NSMutableArray alloc]init];
//        dataArray = [dic objectForKey:@"data"];
//        for (NSDictionary *dict in dataArray) {
//            Modle *mod = [[Modle alloc]init];
//
//            mod.typeName = [dict objectForKey:@"typeName"];
//            mod.interactiveId=dict[@"interactiveId"];
//
//            [array addObject:mod];
//
//        }
//        _modleArray =[NSArray arrayWithArray:array];
        PUSH(SQFLViewController)
//        [self removeFromParentViewController];

//        vc.modleArray=self.modleArray;
        if (_classlab==nil) {
            vc.numb=0;

        }else{

            for (int i =0; i <_modleArray.count; i ++) {
                if ([_classlab isEqualToString:[_modleArray[i] typeName]]) {
                    vc.numb=i;

                    break;
                }
            }
        }


//    }];


//    NSLog(@"controller ===%@",self.navigationController.viewControllers);

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(BOOL)shouldAutorotate
{
    return NO;
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
