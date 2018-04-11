//
//  myShopCell.m
//  logRegister
//
//  Created by apple on 15-1-12.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "myShopCell.h"
#import "define.h"
@implementation myShopCell

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


        UIView*grayView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 15)];
        grayView.backgroundColor=RGB(234, 234, 234);
        [_myView addSubview:grayView];

        UIView*grayView1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 1)];
        grayView1.backgroundColor=RGB(220, 220, 220);
        [_myView addSubview:grayView1];
        UIView*grayView2=[[UIView alloc]initWithFrame:CGRectMake(0, 14, _width, 1)];
        grayView2.backgroundColor=RGB(220, 220, 220);
        [_myView addSubview:grayView2];






        _imageV=[UIButton buttonWithType:UIButtonTypeCustom];
        _imageV.frame=CGRectMake(_width*0.05, 25, 40, 40);
        [_imageV setBackgroundImage:[UIImage imageNamed:@"morentu"] forState:UIControlStateNormal];
    //  [_imageV.layer setMasksToBounds:YES];
        _imageV.layer.cornerRadius=20;
        _imageV.clipsToBounds=YES;
        [_myView addSubview:_imageV];

        _name=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.22, 25, _width*0.58,40)];
        _name.text=@"保密";
        _name.numberOfLines=1;
        _name.font=[UIFont systemFontOfSize:15];
        _name.textAlignment=NSTextAlignmentLeft;
        [_myView addSubview:_name];

        UIView*hengxian=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05, 74, _width, 1)];
        hengxian.backgroundColor=RGB(234, 234, 234);
        [_myView addSubview:hengxian];







//        _locaIV=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.65, 43, 13, 15)];
//        _locaIV.image=[UIImage imageNamed:@"loca"];
       // [_myView addSubview:_locaIV];

        _loca_distance=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.8, 35,_width*0.2, 20)];
        _loca_distance.text=@"";
        _loca_distance.textColor=[UIColor grayColor];
        _loca_distance.textAlignment=NSTextAlignmentCenter;
        _loca_distance.font=[UIFont systemFontOfSize:12];
        [_myView addSubview:_loca_distance];



         UIButton*but=[UIButton buttonWithType:UIButtonTypeCustom];
         but.frame=CGRectMake(_width*0.94 ,39 , 8, 12);
        [but setBackgroundImage:[UIImage imageNamed:@"rightArrow.png"] forState:UIControlStateNormal];
        [_myView addSubview:but];


//       _shuview=[[UIView alloc]initWithFrame:CGRectMake(_width*0.94-10 ,35 , 1, 20)];
//        _shuview.backgroundColor=RGB(220, 220, 220);
//        [_myView addSubview:_shuview];

//        _shopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        _shopBtn.frame=CGRectMake(0, 15, _width,50);
//        
//        _shopBtn.backgroundColor=[UIColor clearColor];
//        [_myView addSubview:_shopBtn];

        




//
//        UIView*grayline=[[UIView alloc]initWithFrame:CGRectMake(_width*0.05, 75, _width, 1)];
//        grayline.backgroundColor=RGB(234,234 , 234);
//        [_myView addSubview:grayline];

        [self addSubview:_myView];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
