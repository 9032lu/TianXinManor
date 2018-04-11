//
//  adviceVC.m
//  logRegister
//
//  Created by apple on 15-1-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "adviceVC.h"

@interface adviceVC ()

@end

@implementation adviceVC
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"意见反馈");
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    //_scrollView.bounces=YES;
    _scrollView.scrollEnabled=YES;
    _scrollView.delegate=self;
   // _scrollView.backgroundColor=[UIColor redColor];
    [self.view addSubview:_scrollView];


    _scrollView.contentSize=CGSizeMake(_width, _height);

    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(_width*0.06, 24, _width*0.88, 150)];
    view.layer.borderColor=RGB(234, 234, 234).CGColor;
    view.layer.borderWidth=2;
    [_scrollView addSubview:view];

//    _advice_tf=[[UITextField alloc]init];
//    _advice_tf.frame=view.frame;
//    _advice_tf.placeholder=@"有啥意见尽管说";

    //[self.view addSubview:_advice_tf];

    _textV=[[UITextView alloc]initWithFrame:CGRectMake(_width*0.06+2, 24+2, _width*0.88-4, 150-4)];
    [_textV becomeFirstResponder];
    //_textV.attributedText=[[NSAttributedString alloc]initWithString:@"有啥意见尽管说"];
    _textV.delegate=self;
    [_scrollView addSubview:_textV];

    _placeholderLabel=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.036, 5, _width*0.94, 20)];
    _placeholderLabel.placeholder=@"请输入您的宝贵意见..";
    _placeholderLabel.textAlignment=NSTextAlignmentLeft;
    _placeholderLabel.font=[UIFont systemFontOfSize:12];
    [_placeholderLabel setEnabled:NO];
    _placeholderLabel.textColor=RGB(180, 180, 180);
    [_textV addSubview:_placeholderLabel];




    UIButton*sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.backgroundColor=APP_ClOUR;
    [sendBtn setTitle:@"发表" forState:UIControlStateNormal];
    sendBtn.frame=CGRectMake(_width*0.06, 250-64, _width*0.88, 40);
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.layer.cornerRadius=3;
    [_scrollView addSubview:sendBtn];


}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
     _placeholderLabel.placeholder=@"";

}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_textV resignFirstResponder];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{



    if (![text isEqualToString:@""])

    {
        _placeholderLabel.hidden = YES;

    }

    if ([text isEqualToString:@""] && range.location == 1 && range.length == 0)

    {

        _placeholderLabel.hidden = NO;
        
    }
    
    return YES;
}
-(void)sendBtnClick
{
    //danLi*myapp=[[danLi alloc]init];
    LOADVIEW
   viewh.remind_L=@"正在提交数据";
    [requestData getData:USER_ADVICE_URL(USERID, _textV.text) complete:^(NSDictionary *dic) {
        if ([[dic objectForKey:@"flag"] intValue]==1) {
            LOADREMOVE

            POP
        }else
        {
            ALERT(@"服务器繁忙，请稍后再试.")
        }

    }];

}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
