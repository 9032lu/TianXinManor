//
//  jubaoVC.m
//  logRegister
//
//  Created by apple on 15-1-23.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "jubaoVC.h"

@interface jubaoVC ()

@end

@implementation jubaoVC

-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"举报")

    _array=@[@"色情淫秽",@"垃圾广告",@"涉及国家安全",@"抄袭原创",@"人身攻击",@"不实信息",@"其他"];


    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.contentSize=CGSizeMake(_width, _height);
    _scrollView.scrollEnabled=YES;
    _scrollView.bounces=YES;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];


    for (int i=0; i<7; i++) {
        int X=i%2;
        int Y=i/2;
        UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(_width*0.02+_width*0.49*X, 90+55*Y-64, _width*0.47, 50);
        button.tag=i+1;

        UIImageView*iv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"default1"]];
        iv.frame=CGRectMake(_width*0.07+_width*0.49*X, 13+90+55*Y-64, 24, 24);
        iv.tag=button.tag;
        [_scrollView addSubview:iv];

        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.02+_width*0.49*X+_width*0.1+20, 0+90+55*Y-64, _width*0.37, 50)];
        label.text=[_array objectAtIndex:i];
        label.tag=button.tag;
        label.textAlignment=NSTextAlignmentLeft;
        label.textColor=[UIColor blackColor];
        [_scrollView addSubview:label];

        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }

    _tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.1, 320-64, _width*0.8, 30)];
    _tf.placeholder=@"请输入举报的原因";
    _tf.borderStyle=UITextAutocapitalizationTypeNone;
    _tf.layer.borderColor=RGB(234, 234, 234).CGColor;
    _tf.layer.borderWidth=1;
    _tf.delegate=self;
    _tf.layer.cornerRadius=3;
    _tf.backgroundColor=[UIColor whiteColor];
    _tf.delegate=self;

    _tf.hidden=YES;
    [_scrollView addSubview:_tf];

    _sendbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    _sendbutton.frame=CGRectMake(_width*0.1, 375-64, _width*0.8, 40);
    [_sendbutton addTarget:self action:@selector(sendbutton:) forControlEvents:UIControlEventTouchUpInside];
    [_sendbutton setTitle:@"发送" forState:UIControlStateNormal];
    _sendbutton.backgroundColor=APP_ClOUR;
    [_scrollView addSubview:_sendbutton];


}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_tf resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)sendbutton:(UIButton*)button
{
    NSLog(@"%ld",(long)button.tag);
    [_tf resignFirstResponder];

        NSString*reportContent=nil;
        if (button.tag<7) {
            if (button.tag==0) {
                MISSINGVIEW
                missing_v.tishi=@"请选择举报原因";
                return;
            }
            reportContent=[_array objectAtIndex:button.tag-1];
        }else
        {
            if (_tf.text.length==0) {
                MISSINGVIEW
                missing_v.tishi=@"请输入举报原因";
                //ALERT(@"请输入举报原因")
                return;
            }
            reportContent=_tf.text;
        }

    LOADVIEW
    viewh.remind_L=@"正在提交数据";
    NSLog(@"%@---%@---%@",self.userId,self.topicsId,reportContent);

        [requestData getData:STORY_LIST_JUBAO_URL(self.userId, self.topicsId, reportContent) complete:^(NSDictionary *dic) {
//            [_denglu removeFromSuperview];
            LOADREMOVE
            if ([[dic objectForKey:@"flag"] intValue]==1) {
                
                ALERT([dic objectForKey:@"info"])
                POP
            }else
            {
                NSLog(@"错误");

            }
            MISSINGVIEW
            missing_v.tishi=[NSString stringWithFormat:@"%@",[dic objectForKey:@"info"]];
        }];

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
    [self getup];


}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"begin");

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _showlabel.text=textField.text;
    return YES;

}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//{
//
//
//}
-(void)getup
{
    if (_keyBoard_H==0) {

        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset=CGPointMake(0, 0);
        }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset=CGPointMake(0, _height-(_keyBoard_H+50+50));
        }];

    }



}
-(CGSize)boundWithSize:(CGSize)size  WithString:(NSString*)str  WithFont:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};

    CGSize retSize = [str boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;

    return retSize;
}

-(void)finishKeyDown:(UIButton*)button
{

    [UIView animateWithDuration:0.3 animations:^{
        button.frame=CGRectMake(0, _height, _width, 40);

//        _showlabel.frame=CGRectMake(0, _height, _width, 40);
    }];
      CGSize size=[self boundWithSize:CGSizeMake(_width, 0) WithString:_tf.text WithFont:[UIFont systemFontOfSize:14]];
     _tf.frame=CGRectMake(_width*0.1, 320, _width*0.8, size.height+25);
    
    [_tf resignFirstResponder];
}
-(void)buttonClick:(UIButton*)button
{
    for (int i=0; i<7; i++) {
        UIImageView*vc=(UIImageView *)[self.view viewWithTag:i+1];
        vc.image=[UIImage imageNamed:@"default1"];
    }
    UIImageView*vc=(UIImageView *)[self.view viewWithTag:button.tag];
    vc.image=[UIImage imageNamed:@"default2"];
    if (button.tag==7) {
        _tf.hidden=NO;
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentOffset=CGPointMake(0, 0);
        }];

        [_tf resignFirstResponder];
        _tf.hidden=YES;
    }
    _sendbutton.tag=button.tag;




}
-(void)backClick
{
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
