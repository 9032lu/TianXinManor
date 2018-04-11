//
//  PostSaleCell.m
//  TianXinManor
//
//  Created by apple on 15/12/11.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "PostSaleCell.h"

@implementation PostSaleCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        _width=[UIScreen mainScreen ].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;


        _productIv=[[UIImageView alloc]initWithFrame:CGRectMake(_width*0.05, 15, _width*0.22, _width*0.22)];

        [self addSubview:_productIv];


        _productName=[[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, 15, _width*0.71-10, 20)];
        _productName.textAlignment=NSTextAlignmentLeft;
        _productName.textColor=[UIColor darkGrayColor];
        _productName.font=[UIFont systemFontOfSize:15];

        _productName.numberOfLines=1;

            _productName.text = @"水电费";
        [self addSubview:_productName];
        
        _stateLab = [[UILabel alloc]initWithFrame:CGRectMake(_width*0.29, 15+_width*0.22-20, _width*0.71-15, 20)];
        _stateLab.textAlignment = NSTextAlignmentRight;
        _stateLab.textColor = [UIColor orangeColor];

        _stateLab.text = @"退款成功";

        _stateLab.font = [UIFont systemFontOfSize:15];
        [self addSubview:_stateLab];



        _RealPrice_La=[[UILabel alloc]init];
        _RealPrice_La.frame=CGRectMake(_width*0.05, _width*0.22+25, _width*0.9, 39);


        _RealPrice_La.textColor=[UIColor orangeColor];
        _RealPrice_La.textAlignment=NSTextAlignmentRight;
        
        _RealPrice_La.font=[UIFont systemFontOfSize:14];
        [self addSubview:_RealPrice_La];


        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, _width*0.22+15+10, _width, 1)];
        line.backgroundColor = RGB(234, 234, 234);
        [self addSubview:line];
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, _width*0.22+64, _width, 10)];
        line1.backgroundColor = RGB(234, 234, 234);
        [self addSubview:line1];

        
    }

    return self;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
