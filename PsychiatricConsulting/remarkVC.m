//
//  remarkVC.m
//  logRegister
//
//  Created by apple on 15-3-20.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "remarkVC.h"
#import "define.h"
@interface remarkVC ()

@end

@implementation remarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"备注")


    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollView.contentSize=CGSizeMake(_width, _height);
    [self.view addSubview:_scrollView];
    _scrollView.delegate=self;
    _scrollView.bounces=YES;

    _placeholderLabel=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.036, 16, _width*0.94, 20)];
    _placeholderLabel.placeholder=@"备注";
    _placeholderLabel.textAlignment=NSTextAlignmentLeft;
    _placeholderLabel.font=[UIFont systemFontOfSize:12];
    [_placeholderLabel setEnabled:NO];
    _placeholderLabel.textColor=RGB(150, 150, 150);
    [_scrollView addSubview:_placeholderLabel];

    _textview=[[UITextView alloc]initWithFrame:CGRectMake(_width*0.03, 11, _width*0.94, 250)];
    _textview.backgroundColor=[UIColor clearColor];
    _textview.delegate=self;
    _textview.layer.borderColor=RGB(234, 234, 234).CGColor;
    _textview.layer.borderWidth=1;
    _textview.clipsToBounds=YES;
    [_textview becomeFirstResponder];
    [_scrollView addSubview:_textview];



    UIButton*pubBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [pubBtn addTarget:self action:@selector(pubClick) forControlEvents:UIControlEventTouchUpInside];
    [pubBtn setTitle:@"确定" forState:UIControlStateNormal];
    [pubBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pubBtn.frame=CGRectMake(_width*0.05, 300, _width*0.9, 50);
    pubBtn.backgroundColor=APP_ClOUR;
    [_scrollView addSubview:pubBtn];

       // Do any additional setup after loading the view.
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_textview resignFirstResponder];
}
-(void)pubClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"remark" object:nil userInfo:@{@"remark":_textview.text}];
    POP

}
-(void)backClick
{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"remark" object:nil userInfo:@{@"remark":_textview.text}];
    POP;
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
