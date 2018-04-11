//
//  ProductCell.m
//  TianXinManor
//
//  Created by apple on 15/12/11.
//  Copyright (c) 2015年 Liuyang. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        _width=[UIScreen mainScreen ].bounds.size.width;
        _height=[UIScreen mainScreen].bounds.size.height;
        self.titleLab= [[UILabel alloc]initWithFrame:CGRectMake(15, 0, _width*0.4, 44)];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.textColor = [UIColor darkGrayColor];
        _titleLab.text = @"标题";
        [self addSubview:_titleLab];

        _contentLab =[[UILabel alloc]initWithFrame:CGRectMake(_width*0.4, 0, _width*0.55, 44)];
        _contentLab.font =[UIFont systemFontOfSize:13];
        _contentLab.textColor =[UIColor blackColor];
        _contentLab.text = @"内容";
        _contentLab.numberOfLines= 0;
        [self addSubview:_contentLab];

        _shuXian =[[UIView alloc]initWithFrame:CGRectMake(_width*0.4-20, 0, 1, 44)];
        _shuXian.backgroundColor = RGB(234, 234, 234);
        [self addSubview:_shuXian];


        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
