//
//  adviceVC.h
//  logRegister
//
//  Created by apple on 15-1-14.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adviceVC : UIViewController<UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
{
    CGFloat         _width;
    CGFloat         _height;
    UIScrollView    *_scrollView;
    UITextView      *_textV;
    UITextField     *_placeholderLabel;
}
@end
/*
UIView *backVW = [[UIView alloc]initWithFrame:CGRectMake(_width*0.15, 2, _width*0.24, 36)];
backVW.backgroundColor =RGB(90,156,207);
backVW.layer.cornerRadius = 5;
[cell.contentView addSubview:backVW];

UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(_width*0.17, 5, _width*0.1, 30)];
image.image = [UIImage imageNamed:@"rili"];
[cell.contentView addSubview:image];
UILabel *lable = [[UILabel alloc]initWithFrame:image.frame];
NSDate *today = [NSDate date];
NSString *weekday = [NSString stringWithFormat:@"%@",[requestData weekdayStringFromDate:today]];
lable.font =[UIFont systemFontOfSize:14];
lable.textColor = [UIColor blackColor];
lable.text =weekday;
lable.textAlignment = NSTextAlignmentCenter;
[cell.contentView addSubview:lable];

selectImg = [[UIButton alloc]initWithFrame:CGRectMake(_width*0.275, 5, _width*0.09, 30)];
selectImg.titleLabel.font = [UIFont systemFontOfSize:14];
[selectImg setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
[cell.contentView addSubview:selectImg];
 


/*/