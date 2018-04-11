//
//  define.h
//  ShengMengShangmao
//
//  Created by apple on 15-3-23.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#ifndef ShengMengShangmao_define_h
#define ShengMengShangmao_define_h

#define  WXAppId   @"wxb08051133a86e266"

#define UMAPPKEY @"563879fe67e58e3caa0027a1"

#define  SCREEN_WIDTH_AND_HEIGHT  CGFloat _width;CGFloat _height;

#define  SCREEN  self.view.backgroundColor=[UIColor whiteColor];_width=[UIScreen mainScreen].bounds.size.width;_height=[UIScreen mainScreen].bounds.size.height;

#define  APP_ClOUR RGB(5,10,79)

#define  TOP_VIEW(string)  SCREEN UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 64)];topView.backgroundColor=APP_ClOUR;[self.view addSubview:topView];UIImageView*backBtn=[[UIImageView alloc]init];backBtn.frame=CGRectMake(_width*0.06, 30, 12, 20);backBtn.image=[UIImage imageNamed:@"leftArrow"];[self.view addSubview:backBtn];BACK UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0, 20, _width, 40)];label.text=string; label.font=[UIFont boldSystemFontOfSize:17];label.textAlignment=NSTextAlignmentCenter;label.textColor=[UIColor whiteColor];[topView addSubview:label];

#define BACK   UIButton*backTi=[UIButton buttonWithType:UIButtonTypeCustom];backTi.frame=CGRectMake(0, 20, _width*0.2, 44);[backTi addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];[topView addSubview:backTi];

#define RGB(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define ALERT(string)  UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:string delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alert show];

#define LOADING_VIEW  _loadingView=[[UIView alloc]initWithFrame:self.view.frame];_loadingView.userInteractionEnabled=YES;_loadingView.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.6];[[UIApplication sharedApplication].keyWindow addSubview:_loadingView];UIActivityIndicatorView*viewh=[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((_width-50)/2, _height/3, 50, 50)];viewh.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;[viewh startAnimating];UILabel*tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, _height/3+50, _width, 50)];tishi.text=@"\t正在加载中...";tishi.textAlignment=NSTextAlignmentCenter;tishi.textColor=[UIColor whiteColor];[_loadingView addSubview:tishi];[_loadingView addSubview:viewh];[self performSelector:@selector(removeLoadView) withObject:nil afterDelay:15];

#define LOADING_REMOVE  [_loadingView removeFromSuperview];


#define GRAY_VIEW(grayView,y,h)  UIView*grayView=[[UIView alloc]initWithFrame:CGRectMake(0, y, _width, h)];grayView.backgroundColor=RGB(234, 234, 234);[_scrollView addSubview:grayView];
#define LABEL_FIFTH_(label,x,y,bl,h,string,a,size,_scrollView) label=[[UILabel alloc]initWithFrame:CGRectMake(x , y , _width*bl , h )];label.text=string;label.textColor=RGB(a, a, a);label.font=[UIFont boldSystemFontOfSize:size];[_scrollView addSubview:label];
#define LABEL_FIFTH(label,x,y,bl,h,string,a,size,_scrollView) UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(x , y , _width*bl , h )];label.text=string;label.textColor=RGB(a, a, a);label.font=[UIFont boldSystemFontOfSize:size];[_scrollView addSubview:label];


#define LABEL_FIFTH(label,x,y,bl,h,string,a,size,_scrollView) UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(x , y , _width*bl , h )];label.text=string;label.textColor=RGB(a, a, a);label.font=[UIFont boldSystemFontOfSize:size];[_scrollView addSubview:label];

#define GREEN_COLOR(view) view.backgroundColor=[UIColor greenColor];
#define YELLOW_COLOR(view) view.backgroundColor=[UIColor yellowColor];

#define GRAY_TIAO(grayline1,grayview,grayline2,h)    UIView*grayline1=[[UIView alloc]initWithFrame:CGRectMake(0, h-1, _width, 1)];grayline1.backgroundColor=RGB(220, 220, 220);[_scrollView addSubview:grayline1];UIView*grayview=[[UIView alloc]initWithFrame:CGRectMake(0, h, _width, 15)];grayview.backgroundColor=RGB(234, 234, 234);[_scrollView addSubview:grayview];UIView*grayline2=[[UIView alloc]initWithFrame:CGRectMake(0, h+15, _width, 1)];grayline2.backgroundColor=RGB(220, 220, 220);[_scrollView addSubview:grayline2];
#define LEFT_ADRESS_L(label,string,y,h,size)   UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(0,y,_width*0.4,h)];label.text=string;label.font=[UIFont systemFontOfSize:size];label.textAlignment=NSTextAlignmentCenter;label.textColor=RGB(1, 1, 1);[_scrollView addSubview:label];
#define RIGHT_LABEL(label,string,y,h,size)   UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.4,y,_width*0.55,h)];label.text=string;label.font=[UIFont systemFontOfSize:size];label.textAlignment=NSTextAlignmentLeft;label.textColor=RGB(155, 155, 155);[_scrollView addSubview:label];
#define RIGHT_TF(text_f,string,y)  text_f=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.4, y, _width*0.6, 50)];text_f.delegate=self;text_f.placeholder=string;[text_f setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];text_f.delegate=self;[_scrollView addSubview:text_f];
#define GRAY_SHU_LINE(view,y)    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(_width*0.37, y, 1,30)];view.backgroundColor=RGB(234, 234, 234);[_scrollView addSubview:view];
#define RIGHT_ADRESS_TF(text_f,string,y)  text_f=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.43, y+3, _width*0.6, 50)];text_f.delegate=self;text_f.placeholder=string;[text_f setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];[_scrollView addSubview:text_f];
#define GRAY_VIEW(grayView,y,h)  UIView*grayView=[[UIView alloc]initWithFrame:CGRectMake(0, y, _width, h)];grayView.backgroundColor=RGB(234, 234, 234);[_scrollView addSubview:grayView];
#define GRAY_UP_DOWN(grayView,y,h)  UIView*grayView=[[UIView alloc]initWithFrame:CGRectMake(0, y, _width, h)];grayView.backgroundColor=RGB(220, 220, 220);[_scrollView addSubview:grayView];
#define GRAY_VIEW_(grayView,y,h)  grayView=[[UIView alloc]initWithFrame:CGRectMake(0, y, _width, h)];grayView.backgroundColor=RGB(234, 234, 234);[_scrollView addSubview:grayView];
#define GRAY_LINE(view,y)   UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, y, _width, 1)];view.backgroundColor=RGB(234, 234, 234);[_scrollView addSubview:view];
#define GRAY_LINE_(view,y)   view=[[UIView alloc]initWithFrame:CGRectMake(0, y, _width, 1)];view.backgroundColor=RGB(234, 234, 234);[_scrollView addSubview:view];
#define GRAY_LINE1(view,x,y,bl,h,a,b,c,_scrollView)   UIView*view=[[UIView alloc]initWithFrame:CGRectMake(x, y, _width*bl, h)];view.backgroundColor=RGB(a, b, c);[_scrollView addSubview:view];



#define  ALLOC(viewColler)  viewColler*vc=[[viewColler alloc]init];
#define  PUSH(viewColler)  viewColler*vc =[[viewColler alloc]init];[self.navigationController pushViewController:vc animated:YES];
#define  POP   [self.navigationController popViewControllerAnimated:YES];

#define  LOADVIEW   myView*viewh=[[myView alloc]initWithFrame:self.view.frame];viewh.backgroundColor=[UIColor clearColor];[self.view addSubview:viewh];viewh.remind_L=@"\t正在加载";
#define  LOADREMOVE  [viewh removeFromSuperview];

#define  MISSINGVIEW  missingView*missing_v=[[missingView alloc]initWithFrame:self.view.frame];missing_v.backgroundColor=[UIColor clearColor];[self.view addSubview:missing_v];

#define  COR_ClOUR RGB(232,232,232)

#define  ORDER_PAY_NOTIFICATION @""


#endif
