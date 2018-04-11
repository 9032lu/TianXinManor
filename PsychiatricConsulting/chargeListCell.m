//
//  chargeListCell.m
//  logRegister
//
//  Created by apple on 15-1-27.
//  Copyright (c) 2015年 LiZhao. All rights reserved.
//

#import "chargeListCell.h"
#import "define.h"
@implementation chargeListCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _width=[UIScreen mainScreen ].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;

        _shopLogo=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.03, 5, 40, 40)];
        _shopLogo.image=[UIImage imageNamed:@"morentu"];
        [self addSubview:_shopLogo];

        _kuang=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03-2, 5-2, 40+4, 40+4)];
        _kuang.layer.borderColor=RGB(234, 234, 234).CGColor;
        _kuang.layer.borderWidth=1;
        [self addSubview:_kuang];



        _shopName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05+50, 0, _width*0.6, 50)];
        _shopName.textAlignment=NSTextAlignmentLeft;
        _shopName.text=@"设计在线";
        _shopName.font=[UIFont boldSystemFontOfSize:16];
        [self addSubview:_shopName];


        _receiveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _receiveBtn.backgroundColor=APP_ClOUR;
        [_receiveBtn setTitle:@"立即使用" forState:UIControlStateNormal];
        [_receiveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _receiveBtn.frame=CGRectMake(_width*0.8, 10, _width*0.15, 30);
        _receiveBtn.layer.cornerRadius=5;
        _receiveBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [self addSubview:_receiveBtn];

//        UIView*grayLine=[[UIView alloc]initWithFrame:CGRectMake(_width*0.03, 50, _width, 1)];
//        grayLine.backgroundColor=RGB(234, 234, 234);
//        [self addSubview:grayLine];


        _chargeName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 50, _width*0.9, 25)];
        _chargeName.textAlignment=NSTextAlignmentLeft;
        _chargeName.text=@"测试优惠劵";
        _chargeName.font=[UIFont systemFontOfSize:14];
        [self addSubview:_chargeName];


//        _startTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.05, 75, _width*0.57, 25)];
//        _startTime.textAlignment=NSTextAlignmentRight;
//        //_chargeName.text=@"测试优惠劵";
//        _startTime.textColor=[UIColor grayColor];
//        _startTime.font=[UIFont systemFontOfSize:12];
//        [self addSubview:_startTime];


        _chargePrice=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 100, _width*0.94, 25)];
        _chargePrice.text=@"优惠金额";
        _chargePrice.textAlignment=NSTextAlignmentLeft;
        _chargePrice.font=[UIFont systemFontOfSize:14];
        [self addSubview:_chargePrice];

//



        _endTime=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 75, _width*0.94, 25)];
       // _chargePrice.text=@"优惠金额";
        _endTime.textColor=[UIColor darkGrayColor];
        _endTime.textAlignment=NSTextAlignmentLeft;
        _endTime.font=[UIFont systemFontOfSize:12];
        [self addSubview:_endTime];


        _couponsDesc=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.03, 125, _width*0.94, 25)];
        _couponsDesc.textAlignment=NSTextAlignmentLeft;
                //_chargeName.text=@"测试优惠劵";
        _couponsDesc.textColor=[UIColor grayColor];
        _couponsDesc.font=[UIFont systemFontOfSize:12];
        [self addSubview:_couponsDesc];



    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
