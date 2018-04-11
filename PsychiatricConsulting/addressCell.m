//
//  addressCell.m
//  logRegister
//
//  Created by apple on 15-1-15.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "addressCell.h"
#import "define.h"
@implementation addressCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _width=[UIScreen mainScreen].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;

        self.adressView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 150)];

//        UIView*grayView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 15)];
//        grayView.backgroundColor=RGB(234, 234, 234);
//        [_adressView addSubview:grayView];
//
//        UIView*grayline=[[UIView alloc]initWithFrame:CGRectMake(0,0, _width, 1)];
//        grayline.backgroundColor=RGB(220, 220, 220);
//        [_adressView addSubview:grayline];
//
//        UIView*grayline1=[[UIView alloc]initWithFrame:CGRectMake(0,14, _width, 1)];
//        grayline1.backgroundColor=RGB(220, 220, 220);
//        [_adressView addSubview:grayline1];

        _linkName_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.04, 20-15, _width*0.4, 25)];
        _linkName_L.text=@"联系人";
        _linkName_L.font=[UIFont systemFontOfSize:14];
        [_adressView addSubview:_linkName_L];

        _phone_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.7, 20-15, _width*0.4, 25)];
        _phone_L.text=@"123456";
        _phone_L.font=[UIFont systemFontOfSize:14];
        [_adressView addSubview:_phone_L];

        _address_L=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.04, 50-15-5, _width*0.96, 35)];
        _address_L.text=@"陕西省西安市";
        _address_L.numberOfLines=0;
        _address_L.font=[UIFont systemFontOfSize:14];
        [_adressView addSubview:_address_L];


        UIView*grayLine=[[UIView alloc]initWithFrame:CGRectMake(0, 80-15, _width, 1)];
        grayLine.backgroundColor=RGB(234, 234, 234);
        [_adressView addSubview:grayLine];


        _isdefault_B=[UIButton buttonWithType:UIButtonTypeCustom];
        _isdefault_B.frame=CGRectMake(0, 80, _width*0.3, 50);


        _isdefault_IV=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.04, 16-15, 18, 18)];
        _isdefault_IV.image=[UIImage imageNamed:@"default1"];
        _isdefault_IV.tag=1111;
        [_isdefault_B addSubview:_isdefault_IV];

        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.08+15, 0-15, _width*0.3, 50)];
        label.text=@"设为默认";
        label.font=[UIFont systemFontOfSize:15];
        label.textAlignment=NSTextAlignmentLeft;
        [_isdefault_B addSubview:label];
        [_adressView addSubview:_isdefault_B];



        _alter_B=[UIButton buttonWithType:UIButtonTypeCustom];
        _alter_B.frame=CGRectMake(_width*0.6, 80, _width*0.2, 50);


        UIImageView*tu2=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.02, 17.5-15, 15, 15)];
        tu2.image=[UIImage imageNamed:@"alter"];
        [_alter_B addSubview:tu2];

        UILabel*label2=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.04+15, 0-15, _width*0.3, 50)];
        label2.text=@"编辑";
        label2.font=[UIFont systemFontOfSize:15];
        label2.textAlignment=NSTextAlignmentLeft;
        [_alter_B addSubview:label2];


        [_adressView addSubview:_alter_B];



        _delete_B=[UIButton buttonWithType:UIButtonTypeCustom];
        _delete_B.frame=CGRectMake(_width*0.8, 80-15, _width*0.2, 50);


        UIImageView*tu3=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.02, 17.5, 15, 15)];
        tu3.image=[UIImage imageNamed:@"delete"];
        [_delete_B addSubview:tu3];

        UILabel*label3=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.04+15, 0, _width*0.3, 50)];
        label3.text=@"删除";
        label3.font=[UIFont systemFontOfSize:15];
        label3.textAlignment=NSTextAlignmentLeft;
        [_delete_B addSubview:label3];


        [_adressView addSubview:_delete_B];






        [self addSubview:_adressView];




    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
