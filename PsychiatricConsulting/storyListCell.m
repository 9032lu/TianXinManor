//
//  storyListCell.m
//  logRegister
//
//  Created by apple on 15-1-23.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "storyListCell.h"
#import "define.h"
@implementation storyListCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _width=[UIScreen mainScreen].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;

        _userFace=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 5, 40, 40)];
       // _userFace.image=[UIImage imageNamed:@"morentu"];
        _userFace.layer.cornerRadius=20;
        _userFace.clipsToBounds=YES;
        [self addSubview:_userFace];


        _userName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+50, 8, _width*0.94-40, 15)];
        _userName.textAlignment=NSTextAlignmentLeft;
        _userName.textColor=[UIColor blackColor];
        _userName.font=[UIFont systemFontOfSize:15];
        //_userName.text=@"比较常见的额";
        [self addSubview:_userName];




        
       _timeIV =[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03+50, 31.5,12, 12)];
        _timeIV.image=[UIImage imageNamed:@"time"];
        [self addSubview:_timeIV];
        _pubTime= [[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+50, 31.5, _width*0.94-40, 12)];
//        _pubTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03+72, 31.5, _width*0.94-55, 12)];
        _pubTime.textAlignment=NSTextAlignmentLeft;
        _pubTime.textColor=[UIColor grayColor];
        _pubTime.font=[UIFont systemFontOfSize:10];
       // _pubTime.text=@"2015-12-21-2    12:54";
        [self addSubview:_pubTime];



        _pubContent=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 55, _width*0.94, 60)];
        _pubContent.textAlignment=NSTextAlignmentCenter;
       // _pubContent.backgroundColor=RGB(244, 244, 244);
        _pubContent.textColor=[UIColor darkGrayColor];
        _pubContent.numberOfLines=0;
        _pubContent.font=[UIFont systemFontOfSize:18];
       // _pubContent.layer.cornerRadius=5;
        //_pubContent.clipsToBounds=YES;
        [self addSubview:_pubContent];

        _detailContent=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 200, _width*0.94, 60)];
        _detailContent.textAlignment=NSTextAlignmentLeft;
        // _pubContent.backgroundColor=RGB(244, 244, 244);
        _detailContent.textColor=[UIColor darkGrayColor];
        _detailContent.numberOfLines=0;
        _detailContent.font=[UIFont systemFontOfSize:14];
        // _pubContent.layer.cornerRadius=5;
        //_pubContent.clipsToBounds=YES;
        [self addSubview:_detailContent];
        



        _manyImageV=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03, 120, _width*0.94, 80)];
       // _manyImageV.backgroundColor=RGB(132, 78, 5);
        [self addSubview:_manyImageV];


        _lowView=[[UIView alloc]initWithFrame:CGRectMake(0, 200, _width, 45)];
//        _lowView.backgroundColor=[UIColor yellowColor];
        [self addSubview:_lowView];


//        UIView*grayline=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03, 10, _width*0.94, 1)];
//        grayline.backgroundColor=RGB(234, 234, 234);
//        [_lowView addSubview:grayline];

//        UIView*grayline1=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03, 45, _width*0.94, 1)];
//        grayline1.backgroundColor=RGB(234, 234, 234);
//        [_lowView addSubview:grayline1];




        _zan_ju_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 45)];
        //_zan_ju_view.backgroundColor=[UIColor yellowColor];
        //_zan_ju_view.backgroundColor=[UIColor orangeColor];
        [_lowView addSubview:_zan_ju_view];

        _jubao=[UIButton buttonWithType:UIButtonTypeCustom];
        _jubao.frame=CGRectMake(0, 0, _width*0.2, 45);
//        _jubao.backgroundColor=[UIColor redColor];
        [_zan_ju_view addSubview:_jubao];

//        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.11, 16, _width*0.12, 12)];
//        label.textAlignment=NSTextAlignmentRight;
//        label.textColor=[UIColor grayColor];
//        label.font=[UIFont systemFontOfSize:12];
//        label.tag=12;
//        label.text=@"举报";
//        [_jubao addSubview:label];

        UIButton *jbbtn =[[UIButton alloc]initWithFrame:CGRectMake(10, 16, _width*0.15, 20)];
        [jbbtn setTitle:@"举报" forState:UIControlStateNormal];
        [jbbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        jbbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        jbbtn.userInteractionEnabled=NO;
        jbbtn.layer.cornerRadius = 7;
        jbbtn.layer.borderWidth=1;
        jbbtn.layer.borderColor= COR_ClOUR.CGColor;
        [_jubao addSubview:jbbtn];



        

        _zanBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _zanBtn.frame=CGRectMake(_width*0.61, 0, _width*0.2, 45);
//        _zanBtn.backgroundColor=[UIColor redColor];
        [_zan_ju_view addSubview:_zanBtn];

        _collectNum=[[UILabel alloc]initWithFrame:CGRectMake(20+_width*0.03, 16, _width*0.6, 16)];
        _collectNum.textAlignment=NSTextAlignmentLeft;
        _collectNum.textColor=[UIColor grayColor];
        _collectNum.font=[UIFont systemFontOfSize:13];
        _collectNum.text=@"18";
        [_zanBtn addSubview:_collectNum];

        UIImageView*zan=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 16, 16, 16)];
        zan.image=[UIImage imageNamed:@"zan2"];
        [_zanBtn addSubview:zan];

        UIButton *zbtn =[[UIButton alloc]initWithFrame:CGRectMake(zan.frame.origin.x-3, 16-2, _width*0.15, 20)];
        zbtn.userInteractionEnabled=NO;
        zbtn.layer.cornerRadius = 7;
        zbtn.layer.borderWidth=1;
        zbtn.layer.borderColor= COR_ClOUR.CGColor;
        [_zanBtn addSubview:zbtn];




        _pinglun = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _pinglun.frame = CGRectMake(_width*0.81, 0, _width*0.2, 45);
//        _pinglun.backgroundColor =[UIColor greenColor];
        [_zan_ju_view addSubview:_pinglun];


        UIImageView*ping=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 16, 16, 16)];
        ping.image=[UIImage imageNamed:@"ping1"];
        [_pinglun addSubview:ping];

        _pinglunLab = [[UILabel alloc]initWithFrame:CGRectMake(20+_width*0.03, 16, _width*0.6, 16)];
//        _pinglunLab.backgroundColor = [UIColor redColor];
        _pinglunLab.textAlignment=NSTextAlignmentLeft;
        _pinglunLab.textColor=[UIColor grayColor];
        _pinglunLab.font=[UIFont systemFontOfSize:13];
        _pinglunLab.text=@"74";
        [_pinglun addSubview:_pinglunLab];

        UIButton *pbtn =[[UIButton alloc]initWithFrame:CGRectMake(ping.frame.origin.x-3, 16-2, _width*0.15, 20)];
        pbtn.userInteractionEnabled =NO;
        pbtn.layer.cornerRadius = 7;
         pbtn.layer.borderWidth=1;
        pbtn.layer.borderColor= COR_ClOUR.CGColor;
        [_pinglun addSubview:pbtn];



        _repalyLab = [[UILabel alloc]init];
        _repalyLab.textColor =[UIColor darkGrayColor];
        _repalyLab.font = [UIFont systemFontOfSize:14];
        _repalyLab.numberOfLines= 0;
        _repalyLab.frame = CGRectMake(_width*0.1, 80, _width*0.85, 50);
        [self addSubview:_repalyLab];
        [_repalyLab sizeToFit];


    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
