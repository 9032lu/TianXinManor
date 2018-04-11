//
//  comentCell.m
//  logRegister
//
//  Created by apple on 15-1-22.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "comentCell.h"

@implementation comentCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _width=[UIScreen mainScreen].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;


        UIView*grayline1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
        grayline1.backgroundColor=RGB(220, 220, 220);
        [self addSubview:grayline1];
        UIView*grayview=[[UIView alloc]initWithFrame:CGRectMake(0, 1, _width, 14)];
        grayview.backgroundColor=RGB(234, 234, 234);
        [self addSubview:grayview];
        UIView*grayline2=[[UIView alloc]initWithFrame:CGRectMake(0, 15, _width, 1)];
        grayline2.backgroundColor=RGB(220, 220, 220);
        [self addSubview:grayline2];



        


        _productIv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 25, _width*0.22, _width*0.22)];
        
        [self addSubview:_productIv];

        _productName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, 25, _width*0.68, _width*0.1)];
        _productName.textAlignment=NSTextAlignmentLeft;
        _productName.textColor=[UIColor blackColor];
        _productName.font=[UIFont systemFontOfSize:15];
        _productName.numberOfLines=1;
        [self addSubview:_productName];

        _price=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.3, _width*0.1+25, _width*0.68, _width*0.1)];
        _price.textAlignment=NSTextAlignmentLeft;
        _price.textColor=[UIColor blackColor];
        _price.font=[UIFont systemFontOfSize:14];
        _price.numberOfLines=1;
        [self addSubview:_price];

        _number_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.7, 45, _width*0.28, 20)];
        _number_L.textAlignment=NSTextAlignmentRight;
        _number_L.textColor=[UIColor grayColor];
        _number_L.font=[UIFont systemFontOfSize:13];
       
        _number_L.numberOfLines=1;
        [self addSubview:_number_L];

        _productBrn=[UIButton buttonWithType:UIButtonTypeCustom];
        _productBrn.frame=CGRectMake(0, 0, _width, _width*0.22+35);
        [self addSubview:_productBrn];


        int h1=_width*0.22+35;



        UIView*grayline3=[[UIView alloc]initWithFrame:CGRectMake(0, h1, _width, 1)];
        grayline3.backgroundColor=RGB(234, 234, 234);
        [self addSubview:grayline3];

        UILabel*decr=[[UILabel alloc]initWithFrame:CGRectMake(0,h1,_width*0.4,40)];
        decr.text=@"描述相符";
        decr.font=[UIFont systemFontOfSize:15];
        decr.textAlignment=NSTextAlignmentCenter;
        decr.textColor=RGB(155, 155, 155);
        [self  addSubview:decr];



        _selectBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn1 setBackgroundImage:[UIImage imageNamed:@"default1"] forState:UIControlStateNormal];
        [_selectBtn1 setBackgroundImage:[UIImage imageNamed:@"default2"] forState:UIControlStateSelected];
        _selectBtn1.frame=CGRectMake(_width*0.4, h1+10, 20, 20);
            
        _selectBtn1.selected=YES;
        //_selectBtn1.backgroundColor=[UIColor orangeColor];
        UIImageView*imagev=[[UIImageView alloc]initWithFrame:CGRectMake(25+5, 2.5, 15, 15)];
        imagev.image=[UIImage imageNamed:@"verygood"];
        //imagev.backgroundColor=[UIColor darkGrayColor];
        [_selectBtn1 addSubview:imagev];

        [self addSubview:_selectBtn1];

        _selectBtn2=[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn2 setBackgroundImage:[UIImage imageNamed:@"default1"] forState:UIControlStateNormal];
        [_selectBtn2 setBackgroundImage:[UIImage imageNamed:@"default2"] forState:UIControlStateSelected];
        _selectBtn2.frame=CGRectMake(_width*0.4+1*_width*0.18, h1+10, 20, 20);

        _selectBtn2.selected=NO;
        UIImageView*imagev1=[[UIImageView alloc]initWithFrame:CGRectMake(25+5, 2.5, 15, 15)];
        imagev1.image=[UIImage imageNamed:@"justsoso"];
        [_selectBtn2 addSubview:imagev1];

        [self addSubview:_selectBtn2];

        _selectBtn3=[UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn3 setBackgroundImage:[UIImage imageNamed:@"default1"] forState:UIControlStateNormal];
        [_selectBtn3 setBackgroundImage:[UIImage imageNamed:@"default2"] forState:UIControlStateSelected];
        _selectBtn3.frame=CGRectMake(_width*0.4+2*_width*0.18, h1+10, 20, 20);

        _selectBtn3.selected=NO;
        UIImageView*imagev2=[[UIImageView alloc]initWithFrame:CGRectMake(25+5, 2.5, 15, 15)];
        imagev2.image=[UIImage imageNamed:@"badly"];
        [_selectBtn3 addSubview:imagev2];

        [self addSubview:_selectBtn3];


        UIView*grayline=[[UIView alloc]initWithFrame:CGRectMake(0, 40+h1, _width, 1)];
        grayline.backgroundColor=RGB(234, 234, 234);
        [self addSubview:grayline];

        UILabel*comment=[[UILabel alloc]initWithFrame:CGRectMake(0,40+h1,_width*0.4,40)];
        comment.text=@"评价内容";
        comment.font=[UIFont systemFontOfSize:15];
        comment.textAlignment=NSTextAlignmentCenter;
        comment.textColor=RGB(155, 155, 155);
        [self addSubview:comment];



        _coment_tf=[[UITextField alloc]initWithFrame:CGRectMake(_width*0.4, 40+h1, _width*0.5, 40)];
        _coment_tf.placeholder=@"输入您的评价";

        [_coment_tf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [self addSubview:_coment_tf];

//
//        _coment_B=[UIButton buttonWithType:UIButtonTypeCustom];
//        _coment_B.frame=CGRectMake(_width*0.4, 40+h1, _width*0.58, 40);
//        [_coment_B setTitle:@"你的评价对商家有很大的帮助!" forState:UIControlStateNormal];
//        [_coment_B setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        _coment_B.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
//        _coment_B.titleLabel.font=[UIFont systemFontOfSize:14];
//        _coment_B.backgroundColor=[UIColor redColor];
//        [self addSubview:_coment_B];

        
        
        
        UIView*grayline4=[[UIView alloc]initWithFrame:CGRectMake(0, 79+h1, _width, 1)];
        grayline4.backgroundColor=RGB(234, 234, 234);
        [self addSubview:grayline4];



    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
