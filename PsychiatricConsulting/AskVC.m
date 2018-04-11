//
//  AskVC.m
//  TianXinManor
//
//  Created by apple on 16/1/18.
//  Copyright © 2016年 Liuyang. All rights reserved.
//

#import "AskVC.h"

@interface AskVC ()<UITextViewDelegate>

@end

@implementation AskVC
//@synthesize currentTextView = _currentTextview;

-(void)backClick{
    [self.view endEditing: YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TOP_VIEW(@"发表咨询")
    _scrollview =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    _scrollview.contentSize = CGSizeMake(_width, _height*2);
    _scrollview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_scrollview];

    UILabel *shengming = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, _width-20, 100)];
    shengming.text = @"声明：您可在购买前对产品包装、颜色、运输、库存等方面进行咨询，我们有专人进行回复！";
    shengming.textColor = [UIColor darkGrayColor];
    shengming.numberOfLines= 0;
    shengming.font = [UIFont systemFontOfSize:14];
    [_scrollview addSubview:shengming];

    CGFloat hh1 = [self boundWithSize:CGSizeMake(_width-20, MAXFLOAT) WithString:shengming.text WithFont:shengming.font].height;
    shengming.frame = CGRectMake(10, 5, _width-20, hh1);

    UILabel *type_S= [[UILabel alloc]initWithFrame:CGRectMake(10, hh1+5+5, _width*0.2, 25)];
    type_S.text = @"咨询类型:";
    type_S.textColor = [UIColor darkGrayColor];
    type_S.font = [UIFont systemFontOfSize:14];
    [_scrollview addSubview:type_S];
    type_A = @[@"商品咨询",@"库存及配送",@"发票",@"其他"];

    askType = type_A[0];

    for (int i = 0; i <type_A.count; i ++) {
        int X =i %2;
        int Y = i/2;

        UIButton *buton =[[UIButton alloc]initWithFrame:CGRectMake(X*_width*0.5+15, hh1+40+Y*35, 20, 20)];
        buton.tag = i;
        [buton setImage:[UIImage imageNamed:@"weiselect2.png"] forState:UIControlStateNormal];
        [buton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollview addSubview:buton];

        if (i ==0) {
            [buton setImage:[UIImage imageNamed:@"selected1.png"] forState:UIControlStateNormal];

            oldBt = buton;

        }

        UILabel *lab =[[UILabel alloc]initWithFrame:CGRectMake(X*_width*0.5+10+35, hh1+35+Y*35, _width*0.5, 30)];
        lab.textColor =[UIColor darkGrayColor];
        lab.text = type_A[i];
        lab.font =[UIFont systemFontOfSize:14];
        [_scrollview addSubview:lab];
    }


    UILabel *content_S= [[UILabel alloc]initWithFrame:CGRectMake(10, hh1+35+70, _width*0.2, 25)];
    content_S.text = @"咨询内容:";
    content_S.textColor = [UIColor darkGrayColor];
    content_S.font = [UIFont systemFontOfSize:14];
    [_scrollview addSubview:content_S];


    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, hh1+130, _width-20, 70)];
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    _textView.delegate = self;
    [_scrollview addSubview:_textView];

    plach_l =[[UILabel alloc]initWithFrame:CGRectMake(10, hh1+130, _width, 20)];
    plach_l.textColor = [UIColor lightGrayColor];
    plach_l.text =@"请输入您的问题...";
    plach_l.font = [UIFont systemFontOfSize:13];
    [_scrollview addSubview:plach_l];
    UIButton *upBtn = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.1, hh1+240, _width*0.8, 40)];
    [upBtn setTitle:@"提交" forState:UIControlStateNormal];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    upBtn.layer.cornerRadius = 5;
    [upBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
    [upBtn addTarget:self action:@selector(upClick) forControlEvents:UIControlEventTouchUpInside];
    upBtn.backgroundColor = APP_ClOUR;
    [_scrollview addSubview:upBtn];
    _scrollview.contentSize =CGSizeMake(_width, MAX(hh1+300, _height+10));

}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    plach_l.text=@"";
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length==0) {
        plach_l.text =@"请输入您的问题...";
    }
}
-(void)btnClick:(UIButton*)button{

    if (button !=oldBt) {
        [button setImage:[UIImage imageNamed:@"selected1.png"] forState:UIControlStateNormal];
        [oldBt setImage:[UIImage imageNamed:@"weiselect2.png"] forState:UIControlStateNormal];
        oldBt = button;

    }
    askType = type_A[button.tag];
}
-(void)upClick{
    if (_textView.text.length ==0) {
        MISSINGVIEW
        missing_v.tishi =@"请输入您的问题";
    }else{
        NSString *url = [NSString stringWithFormat:@"%@/askProduct/add.action",BASE_URLL];
        NSDictionary *paramater = @{@"userId":USERID,@"productId":_productId,@"askType":askType,@"askContent":_textView.text};
        LOADVIEW
        viewh.remind_L =@"正在提交...";
        [requestData PostData:url Parameters:paramater Completion:^(NSError *error, NSDictionary *resultDict) {
            LOADREMOVE

            MISSINGVIEW
            missing_v.tishi =resultDict[@"info"];
            
            if ([resultDict[@"flag"] integerValue]==1) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }


            
        }];

    }
  }
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_scrollview endEditing:YES];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}
//-(void) keyboardWillShow:(NSNotification *)note
//{
//    CGRect keyboardBounds;
//    [[note.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue: &keyboardBounds];
//    keyboardHeight = keyboardBounds.size.height;
//
//    NSLog(@"++++++%d===%d",keyboardIsShowing,keyboardHeight);
//
//    if (keyboardIsShowing == NO) {
//        keyboardIsShowing = YES;
//        CGRect frame = _scrollview.frame;
//        frame.origin.y -= keyboardHeight;
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:0.3f];
//        _scrollview.frame = frame;
//        [UIView commitAnimations];
//    }
//}
//- (void)keyboardWillHide:(NSNotification*)notification {
//    if (!keyboardIsShowing) {
//        return;
//    }
//
//    NSDictionary* userInfo = [notification userInfo];
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:[[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]];
//    [UIView setAnimationCurve:[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
//    //CGRect rect = self.view.bounds;
//    //self.tableView.frame = CGRectMake(0, 0, 320, 416);
//    NSValue *value = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
//    CGSize keyboardSize = [value CGRectValue].size;
//    CGRect viewFrame = _scrollview.frame;
//
//    NSLog(@"------%d===%f",keyboardIsShowing,keyboardSize.height);
//
//    viewFrame.origin.y += keyboardSize.height;
//    _scrollview.frame = viewFrame;
//
//    keyboardIsShowing = NO;
//    [UIView commitAnimations];
//}


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
