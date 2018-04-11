//
//  HelpVC.m
//  TianXinManor
//
//  Created by apple on 16/1/14.
//  Copyright © 2016年 Liuyang. All rights reserved.
//

#import "HelpVC.h"

@interface HelpVC ()<UIScrollViewDelegate>

@end

@implementation HelpVC
-(void)backClick{
    POP
}
- (void)viewDidLoad {
    [super viewDidLoad];
    SCREEN
    TOP_VIEW(@"帮助中心")

    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, _width, _height-64)];
    scrollView.delegate =self;
    [self.view addSubview:scrollView];


    CGSize size=[self boundWithSize:CGSizeMake(_width*0.9, 0) WithString:_context WithFont:[UIFont systemFontOfSize:14]];
    UILabel*help_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 10, _width*0.9, size.height)];
    help_L.text=_context;
    help_L.numberOfLines=0;
    help_L.textColor=[UIColor darkGrayColor];
    help_L.textAlignment=NSTextAlignmentLeft;
    help_L.font=[UIFont systemFontOfSize:14];
    [scrollView addSubview:help_L];
    scrollView.contentSize= CGSizeMake(_width, size.height+20);

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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
