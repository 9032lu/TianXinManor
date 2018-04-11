//
//  myView.m
//  loadIngView
//
//  Created by apple on 15-4-20.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "myView.h"

@implementation myView

- (void)drawRect:(CGRect)rect {
//    self.backgroundColor=[UIColor whiteColor];

    UILabel*label=[[UILabel alloc]init];
    label.backgroundColor=[UIColor colorWithWhite:0.3 alpha:0.6];
    //label.text=@"\t正在加载";
    label.text=[NSString stringWithFormat:@"\t%@",self.remind_L];
    
    label.textColor=[UIColor colorWithWhite:1 alpha:1];
    label.textAlignment=NSTextAlignmentCenter;
    label.bounds=CGRectMake(0, 0, self.frame.size.width*0.6, 60);
    label.layer.cornerRadius=7;
    label.tag=22;
    label.clipsToBounds=YES;

    UIActivityIndicatorView*testView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    testView.frame=CGRectMake(10, 0, 60, 60);
    testView.color=[UIColor whiteColor];
    [testView startAnimating];
    [label addSubview:testView];


    label.center=self.center;
    [self addSubview:label];
    [self performSelector:@selector(chaoshi) withObject:nil afterDelay:30];

}
-(void)chaoshi
{
    if (self.superview==nil) {

    }else
    {
        NSLog(@"++++++++超时、+++++++++++");
        [self removeFromSuperview];
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:@"链接超时,请稍候再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }

    //[self.superview addSubview:]

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/

@end
