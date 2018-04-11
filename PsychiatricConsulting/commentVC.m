//
//  commentVC.m
//  logRegister
//
//  Created by apple on 15-1-21.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "commentVC.h"

#import "comentCell.h"

@interface commentVC ()

@end

@implementation commentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"评价")

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.contentSize=CGSizeMake(_width, _height);
    _scrollView.bounces=YES;
    _scrollView.delegate=self;
    _scrollView.scrollEnabled=YES;
    [self.view addSubview:_scrollView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];


    NSDictionary*orderDic=[self.dic objectForKey:@"order"];

    UILabel*finish_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.1, 10, _width*0.8, 20)];
    finish_L.text=[NSString stringWithFormat:@"下单时间：%@",[orderDic objectForKey:@"orderDate"]];
    finish_L.backgroundColor=RGB(234, 234, 234);
    finish_L.textColor=RGB(180, 180, 180);
    finish_L.textAlignment=NSTextAlignmentCenter;
    finish_L.font=[UIFont systemFontOfSize:13];
    finish_L.layer.cornerRadius=12.5;
    finish_L.clipsToBounds=YES;
    [_scrollView addSubview:finish_L];

    GRAY_LINE(grayline1, 40)




    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(_width*0.05, 40, _width*0.4, 50);
    button.tag=[[orderDic objectForKey:@"shopId"] intValue];
    button.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:button];

    



//    UIImageView*shopIv=[[UIImageView alloc]initWithFrame:CGRectMake(0, 7.5, 35, 35)];
//    [shopIv sd_setImageWithURL:[NSURL URLWithString:[orderDic objectForKey:@"shopLogo"]] placeholderImage:[UIImage imageNamed:@"fang"]];
//    shopIv.layer.borderColor=RGB(234, 234, 234).CGColor;
//    shopIv.layer.borderWidth=1;
//    [button addSubview:shopIv];
//    UILabel*shopName_L=[[UILabel alloc]initWithFrame:CGRectMake(55, 0, _width*0.6, 50)];
//    shopName_L.text=[orderDic objectForKey:@"shopName"];
//    shopName_L.textAlignment=NSTextAlignmentLeft;
//    shopName_L.font=[UIFont boldSystemFontOfSize:15];
//    [button addSubview:shopName_L];



    _goodsArray=[self.dic objectForKey:@"goods"];
//    NSLog(@"%lu",(unsigned long)_goodsArray.count);
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 90-50, _width, _goodsArray.count*(_width*0.22+35+80))];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.scrollEnabled=NO;
    _tableView.rowHeight=_width*0.22+115;
    [_scrollView addSubview:_tableView];



    if (_goodsArray.count*(_width*0.22+35+80)+150>_height) {
        _scrollView.contentSize=CGSizeMake(_width,  _goodsArray.count*(_width*0.22+35+80)+150);
    }
   





    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame=CGRectMake(_width*0.02, _height-50, _width*0.96, 45);
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor=APP_ClOUR;
    submitBtn.layer.cornerRadius=5;
    [self.view addSubview:submitBtn];




}

-(void)submitBtnClick
{

   // danLi*myapp=[[danLi alloc]init];
    NSString*orderNo=[[self.dic objectForKey:@"order"] objectForKey:@"orderNo"];
    NSMutableArray*array=[[NSMutableArray alloc]init];

    for (int i=0; i<_goodsArray.count; i++) {

        NSString*productId=[[_goodsArray objectAtIndex:i] objectForKey:@"productId"];
        NSString* rating;
        NSString* replay;

        NSIndexPath*patn=[NSIndexPath indexPathForRow:i inSection:0];
        comentCell*cell=(comentCell*)[_tableView cellForRowAtIndexPath:patn];
        if (cell.selectBtn1.selected) {
            rating=@"1";
        }
        if (cell.selectBtn2.selected) {
            rating=@"2";
        }
        if (cell.selectBtn3.selected) {
            rating=@"3";
        }
        replay=cell.coment_tf.text;
        
        if (replay==nil ||replay.length==0) {
              isGo= NO;
        }else{
            isGo =YES;
        }

        if (productId==nil) {

        }else
        {
            
            if (rating==nil) {
                NSDictionary*goodDic=@{@"productId": productId,@"userId": USERID,@"orderNo": orderNo,@"rating": @"",@"reply": replay};
                [array addObject:goodDic];

            }else
            {
                NSDictionary*goodDic=@{@"productId": productId,@"userId": USERID,@"orderNo": orderNo,@"rating": rating,@"reply": replay};
                [array addObject:goodDic];

            }


        }




    }
    NSDictionary*dataDic=@{@"comment":array};
    NSLog(@"%@",dataDic);


    NSString*string=[self DataTOjsonString:dataDic];

    if (isGo) {
        [requestData getData:ADD_COMMENT_URL(string) complete:^(NSDictionary *dic) {
            //        NSLog(@"%@",dic);
            if ([[dic objectForKey:@"flag"] intValue]==1) {

                POP
            }else
            {

            }
            MISSINGVIEW
            missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
            
        }];
    }else{
        MISSINGVIEW
        missing_v.tishi = @"请输入评价内容！";
    }

}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_current_Tf resignFirstResponder];

}
//将字典转化为json数据串
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted  error:&error];
    if (! jsonData) {
//        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _goodsArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    comentCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[comentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     NSDictionary*dic=[_goodsArray objectAtIndex:indexPath.row];
    NSString*productId=[dic objectForKey:@"productId"];
    NSString*number=[dic objectForKey:@"number"];
    NSString*productImage=[dic objectForKey:@"productImage"];
    NSString*productName=[dic objectForKey:@"productName"];
    NSString*productPrice=[dic objectForKey:@"productPrice"];

[cell.productIv sd_setImageWithURL:[NSURL URLWithString:productImage] placeholderImage:[UIImage imageNamed:@"doctor"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    float  W=(_width*0.22)*image.size.width/image.size.height;

   cell.productIv.frame = CGRectMake((_width*0.22-W)/2, 15, W, _width*0.22);
}];

     cell.productName.text=productName;
     cell.price.text=[NSString stringWithFormat:@"售价：%.2f元",[productPrice doubleValue]];
     cell.number_L.text=[NSString stringWithFormat:@"购买数量：X%@",number];
    cell.number_L.hidden=YES;

    cell.productBrn.tag=[productId intValue];
    [cell.productBrn addTarget:self action:@selector(productBrnClick:) forControlEvents:UIControlEventTouchUpInside];

    [cell.selectBtn1 addTarget:self action:@selector(sectionSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectBtn2 addTarget:self action:@selector(sectionSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectBtn3 addTarget:self action:@selector(sectionSelectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectBtn1.tag=cell.selectBtn2.tag=cell.selectBtn3.tag=indexPath.row;

    cell.coment_tf.tag=indexPath.row;
    cell.coment_tf.delegate=self;
//    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remarkTfClick:)];
//    [cell.coment_tf addGestureRecognizer:tap];
    //[cell.coment_tf addTarget:self action:@selector(remarkTfClick:) forControlEvents:UIControlEventValueChanged];
    cell.coment_tf.delegate=self;

    _bgView.tag=indexPath.row;
    return cell;
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
        _current_Tf=textField;
       //[self remarkTfClick:textField];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _scrollView.contentOffset=CGPointMake(0, 0);
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    // NSLog(@"hight_hitht:%f",kbSize.height);
    if(kbSize.height == 216)
    {
        _keyBoard_H = 216;
    }
    else
    {
        _keyBoard_H = 252;   //252 - 216 系统键盘的两个不同高度
    }
    NSLog(@"======%f",_keyBoard_H);

    _KeyH=_keyBoard_H;

    [self conffect];
   
}
-(void)conffect
{
    //NSLog(@"%d",_current_Tf.tag);
    [UIView animateWithDuration:0.3 animations:^{
        if (90+(_width*0.22+115)*(_current_Tf.tag+1)+_keyBoard_H-_height+64>=0) {
            _scrollView.contentOffset=CGPointMake(0, 90+(_width*0.22+115)*(_current_Tf.tag+1)-_height+_keyBoard_H+64);

        }

    }];

}
//-(void)showAlterTf
//{
//    UIWindow*window=[UIApplication sharedApplication].keyWindow;
//
//    _bgView=[[UIView alloc]initWithFrame:self.view.frame];
//    _bgView.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.7];
//    //_bgView.alpha=0.7;
//    _bgView.tag=_current_Tf.tag;
//    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleClick:)];
//    tap.numberOfTapsRequired=1;
//    [_bgView addGestureRecognizer:tap];
//    [window addSubview:_bgView];
//
//    _tv=[[UITextView alloc]initWithFrame:CGRectMake(0, _height-_KeyH-140, _width, 100)];
//    _tv.delegate=self;
//    //[_tv becomeFirstResponder];
//
//    [_bgView addSubview:_tv];
//    NSLog(@"%f",_KeyH);
//
//    UIButton*okBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    okBtn.frame=CGRectMake(0, _height-_KeyH-40, _width, 40);
//    okBtn.backgroundColor=RGB(119, 82, 32);
//    okBtn.tag=_bgView.tag;
//    [okBtn setTitle:@"完成" forState:UIControlStateNormal];
//    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [okBtn addTarget:self action:@selector(okclick:) forControlEvents:UIControlEventTouchUpInside];
//    [_bgView addSubview:okBtn];
//
//}
//-(void)okclick:(UIButton*)tf
//{
//    NSIndexPath*path=[NSIndexPath indexPathForRow:tf.tag inSection:0];
//    comentCell*cell=(comentCell*)[_tableView cellForRowAtIndexPath:path];
//    cell.coment_tf.text=_tv.text;
//    //_remark_L.text=[NSString stringWithFormat:@"备注：%@",_tv.text];
//    [_bgView removeFromSuperview];
//    [_current_Tf resignFirstResponder];
//
//}

-(void)doubleClick:(UITapGestureRecognizer*)tap
{
    NSIndexPath*path=[NSIndexPath indexPathForRow:_bgView.tag inSection:0];
    comentCell*cell=(comentCell*)[_tableView cellForRowAtIndexPath:path];
    cell.coment_tf.text=_tv.text;

    [_bgView removeFromSuperview];

}
-(void)productBrnClick:(UIButton*)button
{
//    productDetailVC*vc=[[productDetailVC alloc]init];
//    vc.productID=[NSString stringWithFormat:@"%ld",(long)button.tag];
//    [self.navigationController pushViewController:vc animated:YES];

}

-(void)sectionSelectBtnClick:(UIButton*)button
{

    NSIndexPath*path=[NSIndexPath indexPathForRow:button.tag inSection:0];
    comentCell*cell=(comentCell*)[_tableView cellForRowAtIndexPath:path];
    cell.selectBtn1.selected=cell.selectBtn2.selected=cell.selectBtn3.selected=0;
    button.selected=YES;



}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
