//
//  MyTableViewCell.m
//  logRegister
//
//  Created by apple on 15-1-4.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "MyTableViewCell.h"
#import "define.h"
@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _width=[UIScreen mainScreen].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;

        self.myView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 150)];
        //self.myView.backgroundColor=[UIColor greenColor];


        UIView*grayView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 10)];
        grayView.backgroundColor=RGB(234, 234, 234);
        [_myView addSubview:grayView];

        UIView*grayView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
        grayView1.backgroundColor=RGB(220, 220, 220);
        [_myView addSubview:grayView1];
        UIView*grayView2=[[UIView alloc]initWithFrame:CGRectMake(0, 9, _width, 1)];
        grayView2.backgroundColor=RGB(220, 220, 220);
        [_myView addSubview:grayView2];

        _imageV=[UIButton buttonWithType:UIButtonTypeCustom];
        _imageV.frame=CGRectMake(_width*0.05, 20, _width*0.25, _width*0.25);
        //_imageV.backgroundColor=[UIColor greenColor];
        _imageV.layer.shadowColor=RGB(234,234, 234).CGColor;
        _imageV.layer.cornerRadius=_width*0.125;
        _imageV.clipsToBounds=YES;
        //_imageV.layer.shadowRadius=2;
       // _imageV.layer.shadowOpacity=0.5;

//       _kuang=[[UIView alloc]init];
//        _kuang.frame=CGRectMake(_width*0.05-2, 20-2, _width*0.25+4, _width*0.25+4);
//        _kuang.layer.borderWidth=1;
//        _kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
//        [_myView addSubview:_kuang];

        [_myView addSubview:_imageV];

        _name=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, 20, _width*0.6, _width*0.1)];
        _name.text=@"name";
        _name.numberOfLines=1;
      //  _name.textColor=APP_ClOUR;
        _name.font=[UIFont systemFontOfSize:17];
        _name.textAlignment=NSTextAlignmentLeft;
        [_myView addSubview:_name];

        _shanchang=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, _width*0.15+20, _width*0.6, _width*0.05)];
        // _price.text=@"￥ ";
        _shanchang.textColor=[UIColor darkGrayColor];
        _shanchang.font=[UIFont systemFontOfSize:13];
        _shanchang.textAlignment=NSTextAlignmentLeft;
        [_myView addSubview:_shanchang];


        _price=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.35, _width*0.1+20, _width*0.6, _width*0.05)];
       // _price.text=@"￥ ";
        _price.textColor=[UIColor redColor];
        _price.font=[UIFont systemFontOfSize:14];
        _price.textAlignment=NSTextAlignmentLeft;
        [_myView addSubview:_price];

        _comment=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.35,  _width*0.2+20,_width*0.6, _width*0.05)];
        //_comment.text=@" （4890人）";
        _comment.textColor=[UIColor grayColor];
        _comment.font=[UIFont systemFontOfSize:12];
        _comment.textAlignment=NSTextAlignmentLeft;
        [_myView addSubview:_comment];

        _salesQuality=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.65,  _width*0.2+20,_width*0.3, _width*0.05)];
        //_salesQuality.text=@" （4890人）";
        _salesQuality.textColor=[UIColor grayColor];
        _salesQuality.font=[UIFont systemFontOfSize:12];
        _salesQuality.textAlignment=NSTextAlignmentLeft;
        [_myView addSubview:_salesQuality];

        _distance=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.55,  _width*0.175,_width*0.4, _width*0.075)];
       // _distance.text=@" （4890人）";
        _distance.textColor=[UIColor grayColor];
        _distance.font=[UIFont systemFontOfSize:12];
        _distance.textAlignment=NSTextAlignmentRight;
        [_myView addSubview:_distance];

        _loca_IV=[[UIImageView alloc]init];
        _loca_IV.image=[UIImage imageNamed:@"loca"];
        [_myView addSubview:_loca_IV];


        [self addSubview:_myView];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
